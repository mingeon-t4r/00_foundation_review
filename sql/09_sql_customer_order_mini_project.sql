/*
파일명: 09_sql_customer_order_mini_project.sql
프로젝트명: 00_foundation_review
학습 일차: Day 20
프로젝트 주제: 고객 주문 활동 및 관리 대상 분석

대상 데이터베이스:
D:\Study\SQL\database\retail_lab_day20.db

사용 테이블:
- customers
- orders

테이블 연결:
customers.customer_id = orders.customer_id

분석 단위:
고객 1명당 1행

분석 기준일:
orders 테이블의 가장 최근 order_date

주문 상태:
- paid
- cancelled

프로젝트 질문:
고객별 주문 횟수, 주문 상태, 최근 주문 경과일과
평균 주문 간격을 분석하여 고객 관리 대상을 분류할 수 있는가?

학습용 활동 상태:
- no_order: 주문 이력 없음
- recent: 최근 주문 후 30일 이하
- cooling: 최근 주문 후 31일 이상 60일 이하
- inactive_candidate: 최근 주문 후 60일 초과

학습용 관리 대상:
- activation_candidate: 주문 이력 없음
- order_issue_review: 취소 주문 수가 결제 주문 수보다 많음
- retention_priority: 평균보다 주문이 많고 최근 30일 이내 주문
- reengagement_candidate: 최근 주문 후 60일 초과
- general_management: 그 외 고객

주의:
1. 30일과 60일 기준은 학습용 기준이다.
2. 추가한 고객과 주문 데이터는 학습용 가상 데이터다.
3. orders 테이블에는 상품, 수량과 주문 금액이 없다.
4. 따라서 고객 주문 활동만 분석하며 매출 기여도는 분석하지 않는다.
*/


-- =========================================================
-- 0. 데이터베이스 기본 확인
-- =========================================================

SELECT
    COUNT(*) AS customer_count
FROM customers;


SELECT
    COUNT(*) AS order_count
FROM orders;


SELECT
    status,
    COUNT(*) AS order_count
FROM orders
GROUP BY status
ORDER BY status;


SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS data_reference_date
FROM orders;


-- 예상 결과
-- customers: 30명
-- orders: 104건
-- paid: 86건
-- cancelled: 18건
-- 분석 기간: 2025-11-25 ~ 2026-07-31


-- =========================================================
-- 1. 고객별 주문 흐름 확인
-- 주문 1건당 1행
-- =========================================================

SELECT
    o.customer_id,
    o.order_id,
    o.order_date,
    o.status,

    LAG(o.order_date) OVER (
        PARTITION BY o.customer_id
        ORDER BY
            o.order_date,
            o.order_id
    ) AS previous_order_date

FROM orders AS o
ORDER BY
    o.customer_id,
    o.order_date,
    o.order_id;


-- =========================================================
-- 2. 고객별 주문 간격 확인
-- 주문 1건당 1행
-- =========================================================

SELECT
    customer_id,
    order_id,
    order_date,
    status,
    previous_order_date,

    CASE
        WHEN previous_order_date IS NULL
            THEN NULL
        ELSE CAST(
            julianday(order_date)
            - julianday(previous_order_date)
            AS INTEGER
        )
    END AS days_since_previous_order

FROM (
    SELECT
        o.customer_id,
        o.order_id,
        o.order_date,
        o.status,

        LAG(o.order_date) OVER (
            PARTITION BY o.customer_id
            ORDER BY
                o.order_date,
                o.order_id
        ) AS previous_order_date

    FROM orders AS o
) AS order_flow
ORDER BY
    customer_id,
    order_date,
    order_id;


-- =========================================================
-- 3. 고객별 기본 주문 지표
-- 고객 1명당 1행
-- 주문 없는 고객 포함
-- =========================================================

SELECT
    c.customer_id,
    c.customer_name,
    c.region,
    c.grade,

    COUNT(o.order_id) AS total_order_count,

    SUM(
        CASE
            WHEN o.status = 'paid' THEN 1
            ELSE 0
        END
    ) AS paid_order_count,

    SUM(
        CASE
            WHEN o.status = 'cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_order_count,

    MIN(o.order_date) AS first_order_date,
    MAX(o.order_date) AS last_order_date

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
-- 4. 최종 고객 주문 활동 분석
-- 최종 산출물용 쿼리
-- 고객 1명당 1행
-- =========================================================

SELECT
    customer_features.customer_id,
    customer_features.customer_name,
    customer_features.region,
    customer_features.grade,
    customer_features.total_order_count,
    customer_features.paid_order_count,
    customer_features.cancelled_order_count,
    customer_features.paid_rate,
    customer_features.first_order_date,
    customer_features.last_order_date,
    customer_features.data_reference_date,
    customer_features.active_period_days,
    customer_features.avg_days_between_orders,
    customer_features.recency_days,
    customer_features.avg_customer_order_count,
    customer_features.order_count_rank,

    CASE
        WHEN customer_features.total_order_count = 0
            THEN 'no_order'

        WHEN customer_features.recency_days <= 30
            THEN 'recent'

        WHEN customer_features.recency_days <= 60
            THEN 'cooling'

        ELSE 'inactive_candidate'
    END AS activity_status,

    CASE
        WHEN customer_features.total_order_count = 0
            THEN 'activation_candidate'

        WHEN customer_features.cancelled_order_count
             > customer_features.paid_order_count
            THEN 'order_issue_review'

        WHEN customer_features.total_order_count
             > customer_features.avg_customer_order_count
             AND customer_features.recency_days <= 30
            THEN 'retention_priority'

        WHEN customer_features.recency_days > 60
            THEN 'reengagement_candidate'

        ELSE 'general_management'
    END AS management_action

FROM (
    SELECT
        customer_comparison.customer_id,
        customer_comparison.customer_name,
        customer_comparison.region,
        customer_comparison.grade,
        customer_comparison.total_order_count,
        customer_comparison.paid_order_count,
        customer_comparison.cancelled_order_count,

        CASE
            WHEN customer_comparison.total_order_count = 0
                THEN 0
            ELSE ROUND(
                customer_comparison.paid_order_count
                * 100.0
                / customer_comparison.total_order_count,
                1
            )
        END AS paid_rate,

        customer_comparison.first_order_date,
        customer_comparison.last_order_date,
        customer_comparison.data_reference_date,
        customer_comparison.active_period_days,
        customer_comparison.avg_days_between_orders,

        CASE
            WHEN customer_comparison.last_order_date IS NULL
                THEN NULL
            ELSE CAST(
                julianday(
                    customer_comparison.data_reference_date
                )
                - julianday(
                    customer_comparison.last_order_date
                )
                AS INTEGER
            )
        END AS recency_days,

        customer_comparison.avg_customer_order_count,
        customer_comparison.order_count_rank

    FROM (
        SELECT
            customer_summary.customer_id,
            customer_summary.customer_name,
            customer_summary.region,
            customer_summary.grade,
            customer_summary.total_order_count,
            customer_summary.paid_order_count,
            customer_summary.cancelled_order_count,
            customer_summary.first_order_date,
            customer_summary.last_order_date,
            customer_summary.active_period_days,
            customer_summary.avg_days_between_orders,

            MAX(
                customer_summary.last_order_date
            ) OVER () AS data_reference_date,

            ROUND(
                AVG(
                    customer_summary.total_order_count * 1.0
                ) OVER (),
                2
            ) AS avg_customer_order_count,

            DENSE_RANK() OVER (
                ORDER BY
                    customer_summary.total_order_count DESC
            ) AS order_count_rank

        FROM (
            SELECT
                order_flow.customer_id,
                order_flow.customer_name,
                order_flow.region,
                order_flow.grade,

                COUNT(
                    order_flow.order_id
                ) AS total_order_count,

                SUM(
                    CASE
                        WHEN order_flow.status = 'paid'
                            THEN 1
                        ELSE 0
                    END
                ) AS paid_order_count,

                SUM(
                    CASE
                        WHEN order_flow.status = 'cancelled'
                            THEN 1
                        ELSE 0
                    END
                ) AS cancelled_order_count,

                MIN(
                    order_flow.order_date
                ) AS first_order_date,

                MAX(
                    order_flow.order_date
                ) AS last_order_date,

                CASE
                    WHEN COUNT(order_flow.order_id) >= 2
                        THEN CAST(
                            julianday(
                                MAX(order_flow.order_date)
                            )
                            - julianday(
                                MIN(order_flow.order_date)
                            )
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
                                    julianday(
                                        order_flow.order_date
                                    )
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
                        ORDER BY
                            o.order_date,
                            o.order_id
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
) AS customer_features

ORDER BY
    CASE management_action
        WHEN 'retention_priority' THEN 1
        WHEN 'order_issue_review' THEN 2
        WHEN 'reengagement_candidate' THEN 3
        WHEN 'activation_candidate' THEN 4
        ELSE 5
    END,
    customer_features.order_count_rank,
    customer_features.customer_id;


-- =========================================================
-- 5. 원본 데이터 검증
-- =========================================================

SELECT
    COUNT(*) AS source_customer_count
FROM customers;


SELECT
    COUNT(*) AS source_order_count,
    COUNT(DISTINCT order_id) AS unique_order_count
FROM orders;


SELECT
    COUNT(DISTINCT customer_id)
        AS customer_with_order_count
FROM orders;


-- =========================================================
-- 6. 주문 상태별 검증
-- =========================================================

SELECT
    status,
    COUNT(*) AS order_count
FROM orders
GROUP BY status
ORDER BY status;


-- =========================================================
-- 7. 주문 없는 고객 검증
-- =========================================================

SELECT
    c.customer_id,
    c.customer_name,
    c.region,
    c.grade
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
ORDER BY c.customer_id;


-- 예상 결과
-- 고객 수: 30
-- 주문 수: 104
-- 고유 주문 ID 수: 104
-- 주문 고객 수: 25
-- 주문 없는 고객 수: 5