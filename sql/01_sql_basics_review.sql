-- ==================================================
-- SQL 기초 복습
-- 사용 DB: 기존 12일차 retail_lab.db
-- 기준 테이블: products
-- ==================================================


-- 0. 현재 DB의 테이블 확인
-- 업무 질문:
-- 현재 데이터베이스에는 어떤 테이블이 존재하는가?

SELECT
    name
FROM sqlite_master
WHERE type = 'table'
ORDER BY name;

PRAGMA table_info(products);

SELECT *
FROM products;


-- 1. 전체 상품 조회
-- 업무 질문:
-- 현재 등록된 모든 상품의 정보는 무엇인가?

SELECT
    product_id,
    product_name,
    category,
    unit_price
FROM products;


-- 2. 고가 상품 조회
-- 업무 질문:
-- 판매가격이 300,000원 이상인 상품은 무엇인가?

SELECT
    product_id,
    product_name,
    category,
    unit_price
FROM products
WHERE unit_price >= 300000;


-- 3. 가격이 높은 순서로 조회
-- 업무 질문:
-- 상품을 가격이 높은 순서대로 확인하면 어떻게 되는가?

SELECT
    product_id,
    product_name,
    category,
    unit_price
FROM products
ORDER BY unit_price DESC;


-- 4. 가장 비싼 상품 2개 조회
-- 업무 질문:
-- 현재 가장 가격이 높은 상품 두 개는 무엇인가?

SELECT
    product_id,
    product_name,
    category,
    unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 2;


-- 5. 상품 카테고리 종류 확인
-- 업무 질문:
-- 현재 상품에는 어떤 카테고리가 존재하는가?

SELECT DISTINCT
    category
FROM products
ORDER BY category;