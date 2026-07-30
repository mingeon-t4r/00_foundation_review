/*
=============================================
Project : Foundation Review
Topic   : SQL JOIN
=============================================
*/

-------------------------------------------------
-- 1. 주문 정보 확인
-------------------------------------------------

SELECT *
FROM orders;

-------------------------------------------------
-- 2. 고객 + 주문 INNER JOIN
-------------------------------------------------

SELECT
    c.customer_id,
    c.customer_name,
    c.region,
    c.grade,
    o.order_id,
    o.order_date,
    o.status
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

-------------------------------------------------
-- 3. 고객별 주문 건수
-------------------------------------------------

SELECT
    c.customer_name,
    COUNT(o.order_id) AS order_count
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY order_count DESC;

-------------------------------------------------
-- 4. 지역별 주문 건수
-------------------------------------------------

SELECT
    c.region,
    COUNT(o.order_id) AS order_count
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.region
ORDER BY order_count DESC;

-------------------------------------------------
-- 5. 주문 상태별 건수
-------------------------------------------------

SELECT
    status,
    COUNT(*) AS order_count
FROM orders
GROUP BY status;

-------------------------------------------------
-- 6. LEFT JOIN
-------------------------------------------------

SELECT
    c.customer_name,
    o.order_id,
    o.status
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

-------------------------------------------------
-- 7. 주문이 없는 고객 찾기
-------------------------------------------------

SELECT
    c.customer_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-------------------------------------------------
-- 8. 고객별 마지막 주문일
-------------------------------------------------

SELECT
    c.customer_name,
    MAX(o.order_date) AS last_order
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-------------------------------------------------
-- 9. VIP 고객 주문 조회
-------------------------------------------------

SELECT
    c.customer_name,
    c.grade,
    o.order_date,
    o.status
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE c.grade='VIP';

-------------------------------------------------
-- 10. 지역 + 주문상태 분석
-------------------------------------------------

SELECT
    c.region,
    o.status,
    COUNT(*) AS order_count
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY
    c.region,
    o.status
ORDER BY
    c.region;