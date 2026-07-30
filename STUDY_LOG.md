# STUDY LOG

> Foundation Review 프로젝트 학습 기록

---

# Python

## Day 1

### 개발환경

- Python 설치
- VS Code
- Jupyter Notebook
- Git
- 프로젝트 구조

---

## Day 2

### Python 기초

- 변수
- 자료형
- 문자열
- 리스트
- 딕셔너리
- 연산자

---

## Day 3

### 제어문

- if
- elif
- else
- for
- while
- enumerate

---

## Day 4

### 함수

- 함수 작성
- 매개변수
- return
- 지역변수
- 전역변수

---

## Day 5

### 파일 및 모듈

- 파일 입출력
- 예외 처리
- 모듈
- import

---

## Day 6

### pandas 기초

- DataFrame 생성
- 컬럼 선택
- loc
- iloc

---

## Day 7

### 데이터 처리

- 정렬
- groupby
- value_counts
- 결측치 처리

---

## Day 8

### 데이터 전처리

- CSV 읽기
- CSV 저장
- 문자열 처리
- 컬럼 생성

---

## Day 9

### 데이터 분석

- 집계
- Pivot Table
- agg()
- Excel 저장

---

## Day 10

### 데이터 결합

- merge()
- join
- 시각화

---

## Day 11

### EDA

- 데이터 탐색
- 기술통계
- 시각화
- 분석 과정 정리

---

# SQL

## Day 12

### 데이터베이스 기초

- CREATE TABLE
- PRIMARY KEY
- INSERT
- SELECT

### 생성 파일

- notebooks/01_python_basics_review.ipynb

---

## Day 13

### 데이터 조회

- SELECT
- WHERE
- DISTINCT
- ORDER BY
- LIMIT
- SQL → Python 연결

### 생성 파일

- sql/01_sql_basics_review.sql
- notebooks/02_customer_order_analysis.ipynb
- outputs/region_sales.png
- outputs/customer_summary.csv

---

## Day 14

### 데이터 집계

- COUNT()
- SUM()
- AVG()
- MIN()
- MAX()
- GROUP BY
- ORDER BY

### Python 연동

- pandas.read_sql()
- matplotlib

### 생성 파일

- sql/02_sql_customer_summary.sql
- notebooks/03_sql_python_customer_summary.ipynb
- outputs/region_customer_count.png

---

## Day 15

### SQL JOIN

- INNER JOIN
- LEFT JOIN
- ON
- 별칭(alias)
- JOIN + GROUP BY

### Python 연동

- pandas.read_sql()
- JOIN 결과 DataFrame 생성
- 지역별 주문건수 분석
- 막대그래프 생성

### 생성 파일

- sql/03_sql_customer_sales_join.sql
- notebooks/04_sql_python_customer_sales_analysis.ipynb
- outputs/customer_sales.csv

---

## Day 16

### HAVING

- GROUP BY 결과 필터링
- WHERE와 HAVING 차이 이해

### CASE WHEN

- 조건에 따른 새로운 컬럼 생성
- 고객 등급 분류
- 주문 상태 분류

### SQL 응용

- JOIN + GROUP BY + HAVING
- CASE + GROUP BY

### Python 연동

- pandas.read_sql()
- DataFrame 생성
- CSV 저장

### 생성 파일

- sql/customer_order_summary.sql
- notebooks/customer_order_summary.ipynb
- outputs/customer_order_summary.csv

---

# Statistics

(예정)

---

# 프로젝트 진행 기록

## 현재 완료

- Python 기초 복습
- pandas 기초 복습
- SQL 조회
- SQL 집계

## 진행 예정

- JOIN
- HAVING
- Subquery
- Window Function
- Python 데이터 분석
- Statistics
- Mini Project

---

# 오류 기록

오류와 해결 과정은

```

notes/error_log.md

```

에서 관리합니다.

---

# 배운 점

(학습하면서 느낀 점을 자유롭게 작성)

예)

- SQL은 실행 순서를 이해하는 것이 중요했다.
- GROUP BY는 데이터를 요약하는 핵심 문법이다.
- Python과 SQL을 연결하니 분석 흐름이 이해되기 시작했다.
