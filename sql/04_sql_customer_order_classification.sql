/*
============================================================
File: customer_order_classification.sql
Project: 00_foundation_review
Day: 16

Purpose:
- WHERE와 HAVING의 차이를 확인한다.
- CASE WHEN으로 고객과 주문 상태를 분류한다.
- JOIN, GROUP BY, HAVING을 결합한다.
============================================================
*/


/* =========================================================
1. 고객 등급 분류
------------------------------------------------------------
기존 grade 값을 분석용 고객 유형으로 변환한다.
========================================================= */

SELECT
    *,
    CASE
        WHEN grade = 'VIP' THEN 'Premium'
        WHEN grade = 'GOLD' THEN 'Gold'
        ELSE 'Basic'
    END AS customer_type
FROM customers
ORDER BY customer_id;


/* =========================================================
2. 주문 상태 한글 분류
========================================================= */

SELECT
    *,
    CASE
        WHEN status = 'paid' THEN '결제완료'
        WHEN status = 'cancelled' THEN '주문취소'
        ELSE '기타'
    END AS status_label
FROM orders
ORDER BY order_date;


/* =========================================================
3. 주문 상태별 건수
========================================================= */

SELECT
    CASE
        WHEN status = 'paid' THEN '결제완료'
        WHEN status = 'cancelled' THEN '주문취소'
        ELSE '기타'
    END AS status_label,
    COUNT(*) AS order_count
FROM orders
GROUP BY status_label
ORDER BY order_count DESC;


/* =========================================================
4. 고객별 전체 주문 건수
------------------------------------------------------------
LEFT JOIN으로 주문이 없는 고객도 포함한다.
========================================================= */

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
ORDER BY
    order_count DESC,
    c.customer_id;


/* =========================================================
5. 주문이 2건 이상인 고객
------------------------------------------------------------
집계 이전의 행이 아니라 COUNT 결과를 필터링하므로
WHERE가 아니라 HAVING을 사용한다.
========================================================= */

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS order_count
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
HAVING COUNT(o.order_id) >= 2
ORDER BY order_count DESC;


/* =========================================================
6. 고객이 2명 이상인 지역
========================================================= */

SELECT
    region,
    COUNT(*) AS customer_count
FROM customers
GROUP BY region
HAVING COUNT(*) >= 2
ORDER BY customer_count DESC;


/* =========================================================
7. 결제 완료 주문이 있는 고객
------------------------------------------------------------
WHERE는 GROUP BY 실행 전에 개별 주문을 필터링한다.
========================================================= */

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS paid_order_count
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.status = 'paid'
GROUP BY
    c.customer_id,
    c.customer_name
HAVING COUNT(o.order_id) >= 1
ORDER BY paid_order_count DESC;


/* =========================================================
8. 고객별 주문 상태 집계
------------------------------------------------------------
조건부 집계를 이용해 결제완료와 취소 건수를 분리한다.
========================================================= */

SELECT
    c.customer_id,
    c.customer_name,
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


/* =========================================================
9. 고객 활동 수준 분류
------------------------------------------------------------
고객별 주문 건수를 기준으로 활동 수준을 만든다.
========================================================= */

SELECT
    c.customer_id,
    c.customer_name,
    c.region,
    c.grade,
    COUNT(o.order_id) AS order_count,

    CASE
        WHEN COUNT(o.order_id) >= 2 THEN 'Active'
        WHEN COUNT(o.order_id) = 1 THEN 'Normal'
        ELSE 'Inactive'
    END AS activity_level

FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.region,
    c.grade
ORDER BY
    order_count DESC,
    c.customer_id;


/* =========================================================
10. 고객별 최종 분류 결과
------------------------------------------------------------
Python과 CSV 산출물에서 사용할 최종 쿼리이다.
========================================================= */

SELECT
    c.customer_id,
    c.customer_name,
    c.region,
    c.grade,

    CASE
        WHEN c.grade = 'VIP' THEN 'Premium'
        WHEN c.grade = 'GOLD' THEN 'Gold'
        ELSE 'Basic'
    END AS customer_type,

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

    MAX(o.order_date) AS last_order_date,

    CASE
        WHEN COUNT(o.order_id) >= 2 THEN 'Active'
        WHEN COUNT(o.order_id) = 1 THEN 'Normal'
        ELSE 'Inactive'
    END AS activity_level

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