/*
파일명: day20_expand_retail_lab.sql
목적: 기존 retail_lab.db의 테이블 구조를 유지하면서
      Day 20 미니 프로젝트에 필요한 고객·주문 데이터를 추가한다.

원본 데이터:
- customers: 4명
- orders: 4건
- products: 3건
- order status: paid, cancelled

추가 후:
- customers: 30명
- orders: 104건
- products: 3건

사용 방법:
1. DB Browser for SQLite에서 기존 retail_lab.db를 연다.
2. SQL 실행 탭에서 이 파일의 내용을 실행한다.
3. Write Changes(변경사항 저장)를 누른다.

주의:
- INSERT OR IGNORE를 사용해 같은 ID가 이미 있으면 중복 삽입하지 않는다.
- 실행 전 원본 DB 백업을 권장한다.
*/

PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;

-- =========================================================
-- 1. 고객 데이터 추가
-- =========================================================

INSERT OR IGNORE INTO customers (
    customer_id,
    customer_name,
    region,
    grade
)
VALUES
    (5, 'Han', 'Seoul', 'VIP'),
    (6, 'Jung', 'Busan', 'GOLD'),
    (7, 'Kang', 'Incheon', 'BASIC'),
    (8, 'Cho', 'Daegu', 'GOLD'),
    (9, 'Yoon', 'Daejeon', 'VIP'),
    (10, 'Jang', 'Gwangju', 'BASIC'),
    (11, 'Lim', 'Seoul', 'GOLD'),
    (12, 'Shin', 'Busan', 'BASIC'),
    (13, 'Seo', 'Incheon', 'GOLD'),
    (14, 'Kwon', 'Daegu', 'BASIC'),
    (15, 'Hwang', 'Daejeon', 'VIP'),
    (16, 'Ahn', 'Gwangju', 'GOLD'),
    (17, 'Song', 'Seoul', 'BASIC'),
    (18, 'Ryu', 'Busan', 'BASIC'),
    (19, 'Hong', 'Incheon', 'VIP'),
    (20, 'Jeon', 'Daegu', 'GOLD'),
    (21, 'Ko', 'Daejeon', 'VIP'),
    (22, 'Moon', 'Gwangju', 'BASIC'),
    (23, 'Yang', 'Seoul', 'GOLD'),
    (24, 'Son', 'Busan', 'BASIC'),
    (25, 'Bae', 'Incheon', 'VIP'),
    (26, 'Baek', 'Daegu', 'GOLD'),
    (27, 'Heo', 'Daejeon', 'BASIC'),
    (28, 'Nam', 'Gwangju', 'GOLD'),
    (29, 'Oh', 'Seoul', 'VIP'),
    (30, 'Yoo', 'Busan', 'BASIC');

-- =========================================================
-- 2. 주문 데이터 추가
-- =========================================================

INSERT OR IGNORE INTO orders (
    order_id,
    customer_id,
    order_date,
    status
)
VALUES
    (105, 1, '2026-01-15', 'paid'),
    (106, 1, '2026-02-10', 'paid'),
    (107, 1, '2026-03-05', 'paid'),
    (108, 1, '2026-04-12', 'paid'),
    (109, 1, '2026-05-20', 'paid'),
    (110, 1, '2026-06-18', 'paid'),
    (111, 1, '2026-07-30', 'paid'),
    (112, 2, '2026-01-10', 'paid'),
    (113, 2, '2026-03-15', 'paid'),
    (114, 2, '2026-05-01', 'cancelled'),
    (115, 3, '2026-05-10', 'cancelled'),
    (116, 3, '2026-06-20', 'paid'),
    (117, 3, '2026-07-10', 'cancelled'),
    (118, 5, '2025-12-20', 'paid'),
    (119, 5, '2026-01-20', 'paid'),
    (120, 5, '2026-02-18', 'paid'),
    (121, 5, '2026-03-25', 'paid'),
    (122, 5, '2026-04-22', 'paid'),
    (123, 5, '2026-05-28', 'paid'),
    (124, 5, '2026-06-25', 'paid'),
    (125, 5, '2026-07-31', 'paid'),
    (126, 6, '2026-01-05', 'paid'),
    (127, 6, '2026-02-02', 'paid'),
    (128, 6, '2026-03-09', 'paid'),
    (129, 6, '2026-04-16', 'cancelled'),
    (130, 6, '2026-05-21', 'paid'),
    (131, 6, '2026-06-24', 'paid'),
    (132, 6, '2026-07-24', 'paid'),
    (133, 7, '2026-02-12', 'cancelled'),
    (134, 7, '2026-03-18', 'cancelled'),
    (135, 7, '2026-05-02', 'paid'),
    (136, 7, '2026-06-14', 'cancelled'),
    (137, 7, '2026-07-28', 'cancelled'),
    (138, 8, '2026-03-01', 'paid'),
    (139, 8, '2026-05-16', 'paid'),
    (140, 8, '2026-07-15', 'paid'),
    (141, 9, '2026-01-07', 'paid'),
    (142, 9, '2026-02-14', 'paid'),
    (143, 9, '2026-03-21', 'paid'),
    (144, 9, '2026-05-05', 'paid'),
    (145, 9, '2026-06-17', 'paid'),
    (146, 9, '2026-07-29', 'paid'),
    (147, 10, '2025-12-10', 'paid'),
    (148, 10, '2026-01-25', 'paid'),
    (149, 10, '2026-03-01', 'paid'),
    (150, 10, '2026-04-15', 'paid'),
    (151, 11, '2026-05-30', 'paid'),
    (152, 11, '2026-07-05', 'paid'),
    (153, 13, '2026-02-20', 'paid'),
    (154, 13, '2026-04-12', 'cancelled'),
    (155, 13, '2026-06-10', 'paid'),
    (156, 14, '2026-03-03', 'cancelled'),
    (157, 14, '2026-04-14', 'cancelled'),
    (158, 14, '2026-06-01', 'paid'),
    (159, 14, '2026-07-20', 'cancelled'),
    (160, 15, '2025-11-25', 'paid'),
    (161, 15, '2025-12-30', 'paid'),
    (162, 15, '2026-01-29', 'paid'),
    (163, 15, '2026-02-28', 'paid'),
    (164, 15, '2026-03-20', 'paid'),
    (165, 16, '2026-06-11', 'paid'),
    (166, 16, '2026-07-25', 'paid'),
    (167, 17, '2026-01-17', 'paid'),
    (168, 17, '2026-03-26', 'paid'),
    (169, 17, '2026-05-25', 'paid'),
    (170, 19, '2026-02-05', 'paid'),
    (171, 19, '2026-04-08', 'paid'),
    (172, 19, '2026-06-06', 'paid'),
    (173, 19, '2026-07-18', 'paid'),
    (174, 20, '2025-12-12', 'paid'),
    (175, 20, '2026-02-15', 'paid'),
    (176, 21, '2026-02-01', 'paid'),
    (177, 21, '2026-03-13', 'paid'),
    (178, 21, '2026-04-26', 'cancelled'),
    (179, 21, '2026-06-08', 'paid'),
    (180, 21, '2026-07-27', 'paid'),
    (181, 22, '2026-07-01', 'paid'),
    (182, 23, '2026-03-19', 'cancelled'),
    (183, 23, '2026-05-01', 'paid'),
    (184, 23, '2026-06-20', 'cancelled'),
    (185, 25, '2026-01-12', 'paid'),
    (186, 25, '2026-02-22', 'paid'),
    (187, 25, '2026-04-03', 'paid'),
    (188, 25, '2026-05-14', 'paid'),
    (189, 25, '2026-06-23', 'paid'),
    (190, 25, '2026-07-31', 'paid'),
    (191, 26, '2026-04-07', 'paid'),
    (192, 26, '2026-06-15', 'cancelled'),
    (193, 27, '2025-12-28', 'paid'),
    (194, 27, '2026-02-03', 'paid'),
    (195, 27, '2026-03-16', 'paid'),
    (196, 27, '2026-04-25', 'paid'),
    (197, 28, '2026-04-11', 'paid'),
    (198, 28, '2026-06-02', 'paid'),
    (199, 28, '2026-07-09', 'paid'),
    (200, 29, '2026-02-09', 'paid'),
    (201, 29, '2026-03-22', 'paid'),
    (202, 29, '2026-05-04', 'cancelled'),
    (203, 29, '2026-06-16', 'paid'),
    (204, 29, '2026-07-26', 'paid');

COMMIT;

-- =========================================================
-- 3. 추가 결과 확인
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
    MAX(order_date) AS last_order_date
FROM orders;

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
ORDER BY
    total_order_count DESC,
    c.customer_id;
