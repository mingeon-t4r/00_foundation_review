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

## Day 18 - Window Function을 이용한 고객 주문 순서 분석

### 학습 주제
- Window Function
- OVER
- PARTITION BY
- Window Function의 ORDER BY
- ROW_NUMBER
- RANK
- DENSE_RANK
- LAG
- LEAD
- COUNT OVER
- 고객별 주문 순서와 재주문 간격 분석

### 학습 내용
- 윈도우 함수는 여러 행을 참고해 계산하지만 GROUP BY처럼 상세 행을 줄이지 않는다는 점을 학습했다.
- OVER 안의 PARTITION BY를 사용해 고객별로 계산 범위를 나눴다.
- ROW_NUMBER를 사용해 고객별 주문 순서를 계산했다.
- 같은 주문일이 있을 때 결과를 일정하게 만들기 위해 order_id를 보조 정렬 기준으로 사용했다.
- RANK와 DENSE_RANK를 사용해 고객별 주문 수 순위를 계산하고 동점 처리 차이를 확인했다.
- LAG를 사용해 고객별 이전 주문일을 가져왔다.
- LEAD를 사용해 고객별 다음 주문일을 가져왔다.
- julianday를 사용해 이전 주문 후 현재 주문까지 걸린 일수를 계산했다.
- 윈도우 함수 결과를 필터링하려면 서브쿼리로 한 번 감싸야 한다는 점을 학습했다.

### Python 연동
- pandas.read_sql()을 사용해 고객 주문 순서 분석 결과를 DataFrame으로 불러왔다.
- 주문일, 이전 주문일, 다음 주문일을 datetime 자료형으로 변환했다.
- 주문 ID 중복 여부와 날짜 결측치를 확인했다.
- 고객별 주문 수와 순위를 별도 DataFrame으로 불러왔다.
- 고객별 주문 수 그래프를 생성했다.
- 주문 순서 분석 결과를 CSV로 저장했다.

### 생성 파일
- `sql/06_sql_customer_order_window_analysis.sql`
- `notebooks/07_sql_python_customer_order_window_analysis.ipynb`
- `outputs/customer_order_window_analysis.csv`
- `outputs/customer_order_rank.png`

### 배운 점
- GROUP BY는 여러 행을 그룹별 한 행으로 줄이지만 윈도우 함수는 기존 상세 행을 유지한다.
- PARTITION BY는 고객이 바뀔 때 계산을 다시 시작하게 한다.
- 윈도우 함수 안의 ORDER BY는 계산 순서를 정하고, 쿼리 마지막의 ORDER BY는 결과 표시 순서를 정한다.
- LAG와 LEAD를 이용하면 이전 주문과 다음 주문을 직접 JOIN하지 않고 비교할 수 있다.
- 순위 함수는 동점 처리 방식에 따라 ROW_NUMBER, RANK, DENSE_RANK를 구분해서 사용해야 한다.

### 분석 결과 해석
- 고객별 주문 순서와 이전 주문 후 경과일을 계산해 재주문 흐름을 확인했다.
- 주문 횟수가 많은 고객을 고객 순위로 비교했다.
- 재주문 기간이 짧은 고객은 반복 활동이 상대적으로 높은 고객일 수 있다.
- 현재 데이터에는 주문 금액과 상품 정보가 연결되어 있지 않으므로 주문 횟수가 많다고 해서 매출 기여도가 높다고 판단할 수는 없다.

---

## Day 19 - 고객 주문 데이터 실무 SQL 종합 분석

### 학습 주제
- JOIN, GROUP BY, HAVING 종합 복습
- CASE WHEN 조건부 집계
- Subquery를 이용한 단계별 분석
- LAG를 이용한 주문 간격 계산
- DENSE_RANK를 이용한 고객 순위
- 고객 주문 활동 및 관리 대상 분류

### 학습 내용
- SQL 분석을 시작하기 전에 최종 결과의 행 단위를 고객 1명당 1행으로 정의했다.
- LEFT JOIN을 사용해 주문 이력이 없는 고객까지 분석에 포함했다.
- COUNT(o.order_id)를 사용해 주문이 없는 고객의 주문 수를 0건으로 계산했다.
- CASE WHEN과 SUM을 사용해 완료 주문과 취소 주문을 조건부 집계했다.
- MIN과 MAX를 사용해 고객별 최초 주문일과 최근 주문일을 계산했다.
- LAG를 사용해 고객별 이전 주문일을 가져오고 julianday로 주문 간격을 계산했다.
- 주문 단위로 계산한 간격을 고객 단위 평균으로 다시 집계했다.
- 전체 고객 평균 주문 수를 계산하고 개별 고객의 주문 수와 비교했다.
- DENSE_RANK를 사용해 고객별 주문 수 순위를 계산했다.
- 주문 활동과 주문 상태를 기준으로 고객 관리 대상을 분류했다.

### Python 연동
- pandas.read_sql()을 사용해 고객 주문 종합 분석 결과를 DataFrame으로 불러왔다.
- 최초 주문일과 최근 주문일을 datetime 형식으로 변환했다.
- 고객 ID 중복 여부와 결측치를 확인했다.
- 고객 활동 분류별 인원 수를 계산했다.
- 고객 활동 분류 그래프를 생성했다.
- 최종 분석 결과를 CSV로 저장했다.

### 생성 파일
- `sql/07_sql_customer_order_integrated_analysis.sql`
- `notebooks/08_sql_python_customer_order_integrated_analysis.ipynb`
- `outputs/customer_order_integrated_analysis.csv`
- `outputs/customer_activity_segment.png`

### 배운 점
- 긴 SQL은 한 번에 작성하기보다 주문 단위 계산, 고객 단위 집계, 전체 평균 비교, 최종 분류 순서로 나눠야 한다.
- JOIN 이후 행 단위를 확인하지 않으면 주문 수가 중복되거나 고객이 누락될 수 있다.
- 조건부 집계는 하나의 고객 행에 여러 주문 상태 지표를 함께 만들 수 있다.
- LAG 결과는 주문 단위이므로 고객 단위 분석에 사용하려면 다시 GROUP BY 해야 한다.
- 분석 결과와 관리 대상 분류 규칙은 구분해서 설명해야 한다.

### 분석 결과 해석
- 고객별 주문 횟수, 주문 상태와 주문 간격을 하나의 고객 단위 데이터로 정리했다.
- 평균보다 주문 활동이 높은 고객과 주문 이력이 없는 고객을 구분했다.
- 취소 주문이 완료 주문보다 많은 고객을 별도의 점검 대상으로 분류했다.
- 현재 분석은 주문 횟수와 상태만 사용하므로 매출 기여도나 고객 수익성을 판단할 수 없다.

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
