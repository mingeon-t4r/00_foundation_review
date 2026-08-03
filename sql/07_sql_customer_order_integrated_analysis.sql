/*
파일명: 07_sql_customer_order_integrated_analysis.sql
프로젝트명: 00_foundation_review
학습 일차: Day 19
학습 주제: 실무 SQL 종합 분석

분석 목적:
1. 고객별 전체·완료·취소 주문 수를 계산한다.
2. 고객별 최초 주문일과 최근 주문일을 계산한다.
3. LAG를 이용해 평균 주문 간격을 계산한다.
4. 전체 고객 평균 주문 수와 고객 순위를 계산한다.
5. 고객 활동 수준과 관리 대상을 분류한다.

현재 데이터베이스:
D:\Study\SQL\database\retail_lab.db

사용 테이블:
- customers
- orders

주의:
orders 테이블에는 product_id, quantity, sales_amount가 없다.
따라서 주문 횟수, 상태, 날짜 중심으로 분석한다.
*/


-- =========================================================
-- 0. 테이블과 상태값 확인
-- =========================================================

SELECT
    COUNT(*) AS customer_count
FROM customers;

SELECT
    COUNT(*) AS order_count
FROM orders;

SELECT DISTINCT
    status
FROM orders
ORDER BY status;


-- =========================================================
-- 1. 고객별 전체 주문 수
-- 주문 없는 고객도 포함
-- =========================================================

SELECT
    c.customer_id,
    c.customer_name,
    c.region,
    c.grade,
    COUNT(o.order_id) AS total_order_count
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.region,
    c.grade
ORDER BY
    total_order_count DESC,
    c.customer_id;


-- =========================================================
-- 2. 고객별 주문 상태 조건부 집계
-- =========================================================

SELECT
    c.customer_id,
    c.customer_name,

    COUNT(o.order_id) AS total_order_count,

    SUM(
        CASE
            WHEN o.status = 'completed' THEN 1
            ELSE 0
        END
    ) AS completed_order_count,

    SUM(
        CASE
            WHEN o.status = 'cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_order_count

FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY
    total_order_count DESC,
    c.customer_id;


-- =========================================================
-- 3. 완료 주문이 2건 이상인 고객
-- HAVING 복습
-- =========================================================

SELECT
    c.customer_id,
    c.customer_name,

    SUM(
        CASE
            WHEN o.status = 'completed' THEN 1
            ELSE 0
        END
    ) AS completed_order_count

FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
HAVING completed_order_count >= 2
ORDER BY
    completed_order_count DESC,
    c.customer_id;


-- =========================================================
-- 4. 고객별 이전 주문일과 주문 간격
-- 주문 1건당 1행
-- =========================================================

SELECT
    customer_id,
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
        customer_id,
        order_id,
        order_date,

        LAG(order_date) OVER (
            PARTITION BY customer_id
            ORDER BY order_date, order_id
        ) AS previous_order_date

    FROM orders
) AS order_lag
ORDER BY
    customer_id,
    order_date,
    order_id;


-- =========================================================
-- 5. 고객별 평균 주문 간격
-- 고객 1명당 1행
-- =========================================================

SELECT
    customer_id,

    ROUND(
        AVG(days_since_previous_order),
        1
    ) AS avg_days_between_orders

FROM (
    SELECT
        customer_id,
        order_date,
        previous_order_date,

        CAST(
            julianday(order_date)
            - julianday(previous_order_date)
            AS INTEGER
        ) AS days_since_previous_order

    FROM (
        SELECT
            customer_id,
            order_id,
            order_date,

            LAG(order_date) OVER (
                PARTITION BY customer_id
                ORDER BY order_date, order_id
            ) AS previous_order_date

        FROM orders
    ) AS order_lag
) AS order_interval
GROUP BY customer_id
ORDER BY customer_id;


-- =========================================================
-- 6. 고객별 주문 수 순위
-- =========================================================

SELECT
    customer_id,
    customer_name,
    total_order_count,

    DENSE_RANK() OVER (
        ORDER BY total_order_count DESC
    ) AS order_count_rank

FROM (
    SELECT
        c.customer_id,
        c.customer_name,
        COUNT(o.order_id) AS total_order_count
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.customer_name
) AS customer_orders
ORDER BY
    order_count_rank,
    customer_id;


-- =========================================================
-- 7. 최종 산출물용 쿼리
-- 고객 1명당 1행
-- =========================================================

SELECT
    customer_comparison.customer_id,
    customer_comparison.customer_name,
    customer_comparison.region,
    customer_comparison.grade,
    customer_comparison.total_order_count,
    customer_comparison.completed_order_count,
    customer_comparison.cancelled_order_count,

    CASE
        WHEN customer_comparison.total_order_count = 0 THEN 0
        ELSE ROUND(
            customer_comparison.completed_order_count
            * 100.0
            / customer_comparison.total_order_count,
            1
        )
    END AS completion_rate,

    customer_comparison.first_order_date,
    customer_comparison.last_order_date,
    customer_comparison.active_period_days,
    customer_comparison.avg_days_between_orders,
    customer_comparison.avg_customer_order_count,
    customer_comparison.order_count_rank,

    CASE
        WHEN customer_comparison.total_order_count = 0
            THEN 'no_order'

        WHEN customer_comparison.total_order_count
             > customer_comparison.avg_customer_order_count
            THEN 'high_activity'

        WHEN customer_comparison.total_order_count >= 2
            THEN 'repeat_customer'

        ELSE 'single_order'
    END AS activity_segment,

    CASE
        WHEN customer_comparison.total_order_count = 0
            THEN 'no_order'

        WHEN customer_comparison.completed_order_count
             = customer_comparison.total_order_count
            THEN 'completed_only'

        WHEN customer_comparison.cancelled_order_count
             = customer_comparison.total_order_count
            THEN 'cancelled_only'

        ELSE 'mixed_status'
    END AS status_segment,

    CASE
        WHEN customer_comparison.total_order_count = 0
            THEN 'activation_candidate'

        WHEN customer_comparison.cancelled_order_count
             > customer_comparison.completed_order_count
            THEN 'order_issue_review'

        WHEN customer_comparison.total_order_count
             > customer_comparison.avg_customer_order_count
            THEN 'retention_priority'

        ELSE 'general_management'
    END AS management_action

FROM (
    SELECT
        customer_summary.customer_id,
        customer_summary.customer_name,
        customer_summary.region,
        customer_summary.grade,
        customer_summary.total_order_count,
        customer_summary.completed_order_count,
        customer_summary.cancelled_order_count,
        customer_summary.first_order_date,
        customer_summary.last_order_date,
        customer_summary.active_period_days,
        customer_summary.avg_days_between_orders,

        ROUND(
            AVG(
                customer_summary.total_order_count * 1.0
            ) OVER (),
            2
        ) AS avg_customer_order_count,

        DENSE_RANK() OVER (
            ORDER BY customer_summary.total_order_count DESC
        ) AS order_count_rank

    FROM (
        SELECT
            order_flow.customer_id,
            order_flow.customer_name,
            order_flow.region,
            order_flow.grade,

            COUNT(order_flow.order_id)
                AS total_order_count,

            SUM(
                CASE
                    WHEN order_flow.status = 'completed'
                        THEN 1
                    ELSE 0
                END
            ) AS completed_order_count,

            SUM(
                CASE
                    WHEN order_flow.status = 'cancelled'
                        THEN 1
                    ELSE 0
                END
            ) AS cancelled_order_count,

            MIN(order_flow.order_date)
                AS first_order_date,

            MAX(order_flow.order_date)
                AS last_order_date,

            CASE
                WHEN COUNT(order_flow.order_id) >= 2 THEN
                    CAST(
                        julianday(MAX(order_flow.order_date))
                        - julianday(MIN(order_flow.order_date))
                        AS INTEGER
                    )
                ELSE NULL
            END AS active_period_days,

            ROUND(
                AVG(
                    CASE
                        WHEN order_flow.previous_order_date
                             IS NOT NULL
                        THEN
                            julianday(order_flow.order_date)
                            - julianday(
                                order_flow.previous_order_date
                            )
                        ELSE NULL
                    END
                ),
                1
            ) AS avg_days_between_orders

        FROM (
            SELECT
                c.customer_id,
                c.customer_name,
                c.region,
                c.grade,
                o.order_id,
                o.order_date,
                o.status,

                LAG(o.order_date) OVER (
                    PARTITION BY c.customer_id
                    ORDER BY o.order_date, o.order_id
                ) AS previous_order_date

            FROM customers AS c
            LEFT JOIN orders AS o
                ON c.customer_id = o.customer_id
        ) AS order_flow

        GROUP BY
            order_flow.customer_id,
            order_flow.customer_name,
            order_flow.region,
            order_flow.grade
    ) AS customer_summary
) AS customer_comparison

ORDER BY
    customer_comparison.order_count_rank,
    customer_comparison.customer_id;


-- =========================================================
-- 8. 최종 결과 검증
-- 전체 고객 수와 결과 행 수가 같아야 함
-- =========================================================

SELECT
    COUNT(*) AS customer_count
FROM customers;

SELECT
    COUNT(DISTINCT customer_id)
        AS customer_with_order_count
FROM orders;