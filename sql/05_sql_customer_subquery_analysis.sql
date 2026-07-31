/*
파일명: 05_sql_customer_subquery_analysis.sql
프로젝트명: 00_foundation_review
학습 일차: Day 17
학습 주제: Subquery

분석 목적:
1. 스칼라 서브쿼리로 전체 기준값을 계산한다.
2. IN 서브쿼리로 특정 기간 주문 고객을 조회한다.
3. 상관 서브쿼리로 고객별 주문 수와 주문 기간을 계산한다.
4. NOT EXISTS로 주문 이력이 없는 고객을 찾는다.
5. 고객별 주문 수를 전체 고객 평균과 비교한다.

현재 데이터베이스:
D:\Study\SQL\database\retail_lab.db

현재 사용 테이블:
- customers
- orders
- products

주의:
orders 테이블에는 product_id, quantity, sales_amount가 없다.
따라서 고객·주문 횟수 중심으로만 분석한다.
*/


-- =========================================================
-- 0. 기본 데이터 확인
-- =========================================================

SELECT
    COUNT(*) AS customer_count
FROM customers;

SELECT
    COUNT(*) AS order_count
FROM orders;

SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM orders;


-- =========================================================
-- 1. 스칼라 서브쿼리
-- 전체 주문 데이터의 마지막 주문일을 각 행에 표시
-- =========================================================

SELECT
    order_id,
    customer_id,
    order_date,
    status,
    (
        SELECT MAX(order_date)
        FROM orders
    ) AS database_last_order_date
FROM orders
ORDER BY
    order_date DESC,
    order_id DESC;


-- =========================================================
-- 2. IN 서브쿼리
-- 데이터의 마지막 주문일 기준 최근 30일 주문 고객 조회
-- =========================================================

SELECT
    c.customer_id,
    c.customer_name,
    c.region,
    c.grade
FROM customers AS c
WHERE c.customer_id IN (
    SELECT DISTINCT o.customer_id
    FROM orders AS o
    WHERE o.order_date >= date(
        (SELECT MAX(order_date) FROM orders),
        '-30 days'
    )
)
ORDER BY c.customer_id;


-- =========================================================
-- 3. 상관 서브쿼리
-- 고객별 주문 수, 최초 주문일, 마지막 주문일 계산
-- 고객 1명당 1행
-- =========================================================

SELECT
    c.customer_id,
    c.customer_name,
    c.region,
    c.grade,
    (
        SELECT COUNT(*)
        FROM orders AS o
        WHERE o.customer_id = c.customer_id
    ) AS order_count,
    (
        SELECT MIN(o.order_date)
        FROM orders AS o
        WHERE o.customer_id = c.customer_id
    ) AS first_order_date,
    (
        SELECT MAX(o.order_date)
        FROM orders AS o
        WHERE o.customer_id = c.customer_id
    ) AS last_order_date
FROM customers AS c
ORDER BY
    order_count DESC,
    c.customer_id;


-- =========================================================
-- 4. NOT EXISTS
-- 주문 이력이 없는 고객 조회
-- =========================================================

SELECT
    c.customer_id,
    c.customer_name,
    c.region,
    c.grade
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
)
ORDER BY c.customer_id;


-- =========================================================
-- 5. FROM절 서브쿼리
-- 고객별 주문 수가 전체 고객 평균보다 많은 고객
-- 전체 고객 평균이므로 주문 없는 고객도 평균 계산에 포함
-- =========================================================

SELECT
    customer_orders.customer_id,
    customer_orders.customer_name,
    customer_orders.region,
    customer_orders.grade,
    customer_orders.order_count
FROM (
    SELECT
        c.customer_id,
        c.customer_name,
        c.region,
        c.grade,
        COUNT(o.order_id) AS order_count
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.customer_name,
        c.region,
        c.grade
) AS customer_orders
WHERE customer_orders.order_count > (
    SELECT AVG(order_count * 1.0)
    FROM (
        SELECT
            c2.customer_id,
            COUNT(o2.order_id) AS order_count
        FROM customers AS c2
        LEFT JOIN orders AS o2
            ON c2.customer_id = o2.customer_id
        GROUP BY c2.customer_id
    ) AS customer_order_counts
)
ORDER BY
    customer_orders.order_count DESC,
    customer_orders.customer_id;


-- =========================================================
-- 6. 최종 산출물용 쿼리
-- 고객별 주문 활동을 전체 고객 평균과 비교
-- =========================================================

SELECT
    customer_metrics.customer_id,
    customer_metrics.customer_name,
    customer_metrics.region,
    customer_metrics.grade,
    customer_metrics.order_count,
    customer_metrics.first_order_date,
    customer_metrics.last_order_date,
    CASE
        WHEN customer_metrics.order_count > 0 THEN 1
        ELSE 0
    END AS has_order,
    ROUND(average_metrics.avg_order_count, 2)
        AS avg_customer_order_count,
    CASE
        WHEN customer_metrics.order_count
             > average_metrics.avg_order_count
            THEN 'above_average'
        WHEN customer_metrics.order_count
             = average_metrics.avg_order_count
            THEN 'average'
        ELSE 'below_average'
    END AS comparison_group
FROM (
    SELECT
        c.customer_id,
        c.customer_name,
        c.region,
        c.grade,
        (
            SELECT COUNT(*)
            FROM orders AS o
            WHERE o.customer_id = c.customer_id
        ) AS order_count,
        (
            SELECT MIN(o.order_date)
            FROM orders AS o
            WHERE o.customer_id = c.customer_id
        ) AS first_order_date,
        (
            SELECT MAX(o.order_date)
            FROM orders AS o
            WHERE o.customer_id = c.customer_id
        ) AS last_order_date
    FROM customers AS c
) AS customer_metrics
CROSS JOIN (
    SELECT
        AVG(customer_order_count * 1.0) AS avg_order_count
    FROM (
        SELECT
            c2.customer_id,
            COUNT(o2.order_id) AS customer_order_count
        FROM customers AS c2
        LEFT JOIN orders AS o2
            ON c2.customer_id = o2.customer_id
        GROUP BY c2.customer_id
    ) AS customer_order_counts
) AS average_metrics
ORDER BY
    customer_metrics.order_count DESC,
    customer_metrics.customer_id;


-- =========================================================
-- 7. 검증용 쿼리
-- 고객 수, 주문 없는 고객 수, 평균 주문 수 확인
-- =========================================================

SELECT
    COUNT(*) AS customer_count,
    SUM(
        CASE
            WHEN order_count = 0 THEN 1
            ELSE 0
        END
    ) AS no_order_customer_count,
    ROUND(AVG(order_count * 1.0), 2) AS avg_order_count
FROM (
    SELECT
        c.customer_id,
        COUNT(o.order_id) AS order_count
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
) AS customer_order_counts;