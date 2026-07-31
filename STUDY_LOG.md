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

- sql/04_sql_customer_order_classification.sql
- notebooks/05_sql_python_customer_order_classification.ipynb
- outputs/customer_order_classification.csv

---

## Day 17 - Subquery를 이용한 고객 주문 비교 분석

### 학습 주제
- Subquery 기본 구조
- Scalar Subquery
- IN Subquery
- Correlated Subquery
- EXISTS / NOT EXISTS
- FROM절 Subquery
- 고객별 주문 수와 전체 고객 평균 비교

### 학습 내용
- 서브쿼리는 다른 SQL 문장 안에 포함되어 중간 기준값이나 대상 목록을 만드는 쿼리임을 학습했다.
- 전체 평균이나 최댓값처럼 1행 1열 결과가 필요한 경우 스칼라 서브쿼리를 사용했다.
- 주문 고객 ID 목록을 만든 뒤 IN을 이용해 해당 고객 정보를 조회했다.
- 바깥 쿼리의 customer_id를 참조하는 상관 서브쿼리로 고객별 주문 수, 최초 주문일, 마지막 주문일을 계산했다.
- EXISTS와 NOT EXISTS를 이용해 주문 이력의 존재 여부를 확인했다.
- FROM절 서브쿼리로 고객별 주문 수 집계 결과를 임시 테이블처럼 사용했다.
- 전체 가입 고객을 기준으로 평균 주문 수를 계산하기 위해 LEFT JOIN과 COUNT(o.order_id)를 사용했다.

### Python 연동
- sqlite3와 pandas.read_sql_query()를 이용해 서브쿼리 결과를 DataFrame으로 불러왔다.
- first_order_date와 last_order_date를 datetime 형식으로 변환했다.
- SQL에서 계산한 평균 주문 수와 pandas의 mean() 결과를 비교했다.
- 고객별 주문 수와 전체 평균을 비교하는 막대그래프를 생성했다.
- 분석 결과를 CSV와 PNG로 저장했다.

### 생성 파일
- `sql/05_sql_customer_subquery_analysis.sql`
- `notebooks/06_sql_python_customer_subquery_analysis.ipynb`
- `outputs/customer_subquery_analysis.csv`
- `outputs/customer_order_count_vs_average.png`

### 배운 점
- 서브쿼리는 복잡한 업무 질문을 중간 결과와 최종 결과로 나누는 데 유용하다.
- 상관 서브쿼리는 바깥 쿼리의 각 행을 참조하므로 일반 서브쿼리와 실행 관점이 다르다.
- 주문이 없는 고객까지 평균에 포함하려면 LEFT JOIN과 COUNT(o.order_id)를 사용해야 한다.
- 평균은 일부 다주문 고객의 영향을 받을 수 있으므로 이후 중앙값이나 분포도 함께 확인해야 한다.

### 분석 결과 해석
- 고객별 주문 수를 전체 고객 평균과 비교하여 평균 이상, 평균, 평균 미만 그룹으로 구분했다.
- 주문 이력이 없는 고객은 재활성화 대상 후보로 볼 수 있다.
- 현재 orders 테이블에는 상품, 수량, 매출액 정보가 없으므로 주문 횟수만으로 고객 가치를 판단할 수 없다.

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
