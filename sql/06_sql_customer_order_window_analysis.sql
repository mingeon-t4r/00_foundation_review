/*
파일명: 06_sql_customer_order_window_analysis.sql
프로젝트명: 00_foundation_review
학습 일차: Day 18
학습 주제: Window Function

분석 목적:
1. 고객별 주문 순서를 계산한다.
2. 고객별 이전 주문일과 다음 주문일을 계산한다.
3. 이전 주문 후 경과일을 계산한다.
4. 주문 상세 행을 유지하면서 고객별 전체 주문 수를 표시한다.
5. 고객별 주문 횟수 순위를 계산한다.

현재 데이터베이스:
D:\Study\SQL\database\retail_lab.db

사용 테이블:
- customers
- orders

주의:
orders 테이블에는 product_id, quantity, sales_amount가 없다.
따라서 고객별 주문 순서, 주문 횟수, 주문 간격만 분석한다.
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
-- 1. 전체 주문 순번
-- 전체 주문을 날짜순으로 번호 매기기
-- =========================================================

SELECT
    order_id,
    customer_id,
    order_date,
    status,
    ROW_NUMBER() OVER (
        ORDER BY order_date, order_id
    ) AS overall_order_sequence
FROM orders
ORDER BY overall_order_sequence;


-- =========================================================
-- 2. 고객별 주문 순번
-- 고객이 바뀌면 주문 순서가 1부터 다시 시작
-- =========================================================

SELECT
    order_id,
    customer_id,
    order_date,
    status,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS order_sequence
FROM orders
ORDER BY customer_id, order_sequence;


-- =========================================================
-- 3. 고객별 최근 주문
-- 최신 주문을 1번으로 만든 뒤 첫 행만 조회
-- =========================================================

SELECT
    customer_id,
    order_id,
    order_date,
    status
FROM (
    SELECT
        customer_id,
        order_id,
        order_date,
        status,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date DESC, order_id DESC
        ) AS recent_order_sequence
    FROM orders
) AS recent_orders
WHERE recent_order_sequence = 1
ORDER BY customer_id;


-- =========================================================
-- 4. 고객별 이전 주문일과 다음 주문일
-- =========================================================

SELECT
    order_id,
    customer_id,
    order_date,
    LAG(order_date) OVER (
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS previous_order_date,
    LEAD(order_date) OVER (
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS next_order_date
FROM orders
ORDER BY customer_id, order_date, order_id;


-- =========================================================
-- 5. 주문 상세 행을 유지하면서 고객 전체 주문 수 표시
-- =========================================================

SELECT
    order_id,
    customer_id,
    order_date,
    status,
    COUNT(*) OVER (
        PARTITION BY customer_id
    ) AS customer_total_orders
FROM orders
ORDER BY customer_id, order_date, order_id;


-- =========================================================
-- 6. 고객별 주문 횟수 순위
-- 주문이 없는 고객도 포함
-- =========================================================

SELECT
    customer_id,
    customer_name,
    region,
    grade,
    order_count,
    RANK() OVER (
        ORDER BY order_count DESC
    ) AS order_rank,
    DENSE_RANK() OVER (
        ORDER BY order_count DESC
    ) AS dense_order_rank
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
ORDER BY order_rank, customer_id;


-- =========================================================
-- 7. 재주문까지 30일 이상 걸린 주문
-- 첫 주문은 이전 주문이 없으므로 제외
-- =========================================================

SELECT
    customer_id,
    customer_name,
    order_id,
    order_date,
    previous_order_date,
    days_since_previous_order
FROM (
    SELECT
        customer_id,
        customer_name,
        order_id,
        order_date,
        previous_order_date,
        CAST(
            julianday(order_date)
            - julianday(previous_order_date)
            AS INTEGER
        ) AS days_since_previous_order
    FROM (
        SELECT
            c.customer_id,
            c.customer_name,
            o.order_id,
            o.order_date,
            LAG(o.order_date) OVER (
                PARTITION BY o.customer_id
                ORDER BY o.order_date, o.order_id
            ) AS previous_order_date
        FROM orders AS o
        INNER JOIN customers AS c
            ON o.customer_id = c.customer_id
    ) AS order_lag
) AS order_interval
WHERE days_since_previous_order >= 30
ORDER BY
    days_since_previous_order DESC,
    customer_id,
    order_date;


-- =========================================================
-- 8. 최종 산출물용 쿼리
-- 고객별 주문 순서, 이전·다음 주문일, 재주문 간격
-- 주문 1건당 1행
-- =========================================================

SELECT
    order_sequence.customer_id,
    order_sequence.customer_name,
    order_sequence.region,
    order_sequence.grade,
    order_sequence.order_id,
    order_sequence.order_date,
    order_sequence.status,
    order_sequence.order_sequence,
    order_sequence.customer_total_orders,
    order_sequence.previous_order_date,
    CAST(
        julianday(order_sequence.order_date)
        - julianday(order_sequence.previous_order_date)
        AS INTEGER
    ) AS days_since_previous_order,
    order_sequence.next_order_date,
    CASE
        WHEN order_sequence.order_sequence = 1 THEN 1
        ELSE 0
    END AS is_first_order
FROM (
    SELECT
        c.customer_id,
        c.customer_name,
        c.region,
        c.grade,
        o.order_id,
        o.order_date,
        o.status,
        ROW_NUMBER() OVER (
            PARTITION BY o.customer_id
            ORDER BY o.order_date, o.order_id
        ) AS order_sequence,
        COUNT(*) OVER (
            PARTITION BY o.customer_id
        ) AS customer_total_orders,
        LAG(o.order_date) OVER (
            PARTITION BY o.customer_id
            ORDER BY o.order_date, o.order_id
        ) AS previous_order_date,
        LEAD(o.order_date) OVER (
            PARTITION BY o.customer_id
            ORDER BY o.order_date, o.order_id
        ) AS next_order_date
    FROM orders AS o
    INNER JOIN customers AS c
        ON o.customer_id = c.customer_id
) AS order_sequence
ORDER BY
    order_sequence.customer_id,
    order_sequence.order_sequence;


-- =========================================================
-- 9. 검증용 쿼리
-- 결과 주문 수가 원본 주문 수와 같은지 확인
-- =========================================================

SELECT
    COUNT(*) AS source_order_count,
    COUNT(DISTINCT order_id) AS unique_order_count
FROM orders;