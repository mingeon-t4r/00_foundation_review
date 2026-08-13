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

## Day 20 - 확장 데이터 기반 SQL 고객 주문 미니 프로젝트

### 데이터 확장 배경

기존 `retail_lab.db`는 고객 4명과 주문 4건으로 구성되어 있어
고객 순위, 주문 간격, 최근성과 관리 대상 분류를 비교하기에 데이터가 부족했다.

원본 데이터베이스는 보존하고,
학습용 고객과 주문 데이터를 추가한 `retail_lab_day20.db`를 별도로 사용했다.

### 확장 후 데이터

- 고객: 30명
- 주문: 104건
- paid 주문: 86건
- cancelled 주문: 18건
- 주문 고객: 25명
- 주문 없는 고객: 5명
- 분석 기간: 2025-11-25 ~ 2026-07-31

추가한 고객과 주문 데이터는 SQL 학습을 위한 가상 데이터다.

### 프로젝트 주제

고객 주문 활동 및 관리 대상 분석

### 문제 정의

고객 관리 담당자가 유지, 재활성화와 주문 문제 점검 대상의
우선순위를 정할 수 있도록 고객별 주문 횟수, 주문 상태,
최근 주문 경과일과 평균 주문 간격을 고객 단위로 분석했다.

### 분석 범위

- 데이터베이스: `D:\Study\SQL\database\retail_lab_day20.db`
- 사용 테이블: `customers`, `orders`
- 연결 키: `customer_id`
- 분석 단위: 고객 1명당 1행
- 분석 기준일: orders 테이블의 최대 order_date
- 주문 상태: `paid`, `cancelled`

### 핵심 지표

- 전체 주문 수
- paid 주문 수
- cancelled 주문 수
- paid 비율
- 최초 주문일
- 최근 주문일
- 고객 활동 기간
- 평균 주문 간격
- 최근 주문 경과일
- 전체 고객 평균 주문 수
- 주문 수 순위

### 고객 활동 상태

- `no_order`: 주문 이력 없음
- `recent`: 최근 주문 후 30일 이하
- `cooling`: 최근 주문 후 31일 이상 60일 이하
- `inactive_candidate`: 최근 주문 후 60일 초과

### 관리 대상 분류

- `activation_candidate`: 주문 이력이 없는 고객
- `order_issue_review`: 취소 주문 수가 paid 주문 수보다 많은 고객
- `retention_priority`: 평균보다 주문이 많고 최근 30일 이내 주문한 고객
- `reengagement_candidate`: 최근 주문 후 60일이 지난 고객
- `general_management`: 그 외 고객

30일과 60일은 학습을 위해 정한 기준이며 실제 업무 정책은 아니다.

### SQL 학습 내용

- 원본 DB를 보존하고 별도의 확장 DB를 사용했다.
- `INSERT OR IGNORE`를 사용해 학습용 고객과 주문 데이터를 추가했다.
- 데이터 생성 SQL과 분석 SQL을 별도 파일로 분리했다.
- `LEFT JOIN`을 사용해 주문 이력이 없는 고객까지 분석에 포함했다.
- `COUNT(o.order_id)`를 사용해 주문 없는 고객의 주문 수를 0건으로 계산했다.
- `CASE WHEN`과 `SUM()`을 사용해 paid 주문과 cancelled 주문을 조건부 집계했다.
- `MIN()`과 `MAX()`를 사용해 고객별 최초 주문일과 최근 주문일을 계산했다.
- `LAG()`를 사용해 고객별 이전 주문일을 계산했다.
- `julianday()`를 사용해 주문 간격과 최근 주문 경과일을 계산했다.
- `AVG() OVER()`를 사용해 전체 고객 평균 주문 수를 계산했다.
- `DENSE_RANK()`를 사용해 고객별 주문 수 순위를 계산했다.
- 여러 단계의 서브쿼리를 사용해 주문 단위 데이터를 고객 단위 데이터로 변환했다.
- `CASE WHEN`을 사용해 고객 활동 상태와 관리 대상을 분류했다.

### Python 연동

- `pandas.read_sql()`을 사용해 SQL 분석 결과를 DataFrame으로 불러왔다.
- 고객 수와 주문 수를 별도 SQL로 확인했다.
- 주문 상태와 분석 기간을 확인했다.
- 날짜 열을 datetime 형식으로 변환했다.
- 고객 ID 중복 여부를 확인했다.
- 고객별 전체 주문 수 합계와 원본 주문 수를 비교했다.
- 고객별 paid 주문 수 합계와 원본 paid 주문 수를 비교했다.
- 고객별 cancelled 주문 수 합계와 원본 cancelled 주문 수를 비교했다.
- 활동 상태별 고객 수를 확인했다.
- 관리 대상별 고객 수와 평균 주문 수를 집계했다.
- 관리 대상별 고객 목록을 확인했다.
- 최종 고객 분석 CSV와 관리 대상 요약 CSV를 저장했다.
- 관리 대상별 고객 수 그래프를 저장했다.

### 생성 파일

- `sql/08_sql_retail_lab_day20_seed.sql`
- `sql/09_sql_customer_order_mini_project.sql`
- `notebooks/09_sql_python_customer_order_mini_project.ipynb`
- `outputs/customer_order_mini_project.csv`
- `outputs/customer_management_summary.csv`
- `outputs/customer_management_action.png`
- `notes/sql_customer_order_mini_project_report.md`

### 수정 파일

- `README.md`
- `STUDY_LOG.md`

### 보존한 Day 19 파일

- `sql/07_sql_customer_order_integrated_analysis.sql`
- `notebooks/08_sql_python_customer_order_integrated_analysis.ipynb`
- `outputs/customer_order_integrated_analysis.csv`
- `outputs/customer_activity_segment.png`

Day 19 파일은 당시의 SQL 종합 학습 결과로 유지하고,
Day 20 미니 프로젝트는 별도의 SQL과 Notebook으로 분리했다.

### 결과 검증

- 전체 고객 수: 30명
- 최종 분석 행 수: 30행
- 고객 ID 중복 수: 0
- 원본 주문 수: 104건
- 고객별 전체 주문 수 합계: 104건
- 원본 paid 주문 수: 86건
- 고객별 paid 주문 수 합계: 86건
- 원본 cancelled 주문 수: 18건
- 고객별 cancelled 주문 수 합계: 18건
- 주문 없는 고객 수: 5명

### 핵심 결과

- 전체 고객의 평균 주문 수는 약 3.47건이다.
- 전체 주문 중 paid 주문 비율은 약 82.7%다.
- recent 고객은 17명이다.
- cooling 고객은 3명이다.
- inactive_candidate 고객은 5명이다.
- no_order 고객은 5명이다.
- retention_priority 고객은 9명이다.
- order_issue_review 고객은 4명이다.
- reengagement_candidate 고객은 5명이다.
- activation_candidate 고객은 5명이다.
- general_management 고객은 7명이다.

### 결과 해석

`retention_priority` 고객군은 평균 주문 수가 6건이고
평균 최근 주문 경과일이 약 4.7일로 주문 빈도와 최근 활동이 모두 높았다.

`reengagement_candidate` 고객군은 평균 주문 수가 3.6건으로
과거 주문 경험은 있지만 평균 최근 주문 경과일이 약 114일로 주문 공백이 길었다.

`order_issue_review` 고객은 최근 주문 활동이 존재하지만
cancelled 주문 수가 paid 주문 수보다 많아 주문 과정의 문제를 추가로 확인할 필요가 있다.

`activation_candidate` 고객 5명 중 4명이 Busan 지역 고객으로,
지역별 가입 경로나 첫 구매 과정에 차이가 있는지 추가 확인할 수 있다.

### 배운 점

- 분석 목적에 비해 데이터가 지나치게 적으면 SQL이 실행되어도 의미 있는 비교가 어렵다.
- 학습 데이터를 추가할 때는 원본 DB를 보존하고 별도 복사본을 사용하는 것이 안전하다.
- 실제 DB의 상태값을 확인하지 않고 `completed`와 같은 값을 가정하면 조건부 집계가 잘못된다.
- 데이터 생성 SQL과 최종 분석 SQL을 분리하면 각 파일의 역할이 명확해진다.
- Day 19 종합 학습 파일과 Day 20 완성형 프로젝트 파일을 분리하면 학습 과정과 프로젝트 결과를 모두 보존할 수 있다.
- 최종 SQL이 실행됐다는 사실만으로는 충분하지 않고 고객 수, 중복과 주문 수 합계를 별도로 검증해야 한다.
- 관리 대상 분류는 데이터에서 관측된 값과 학습용 업무 규칙을 결합한 결과다.
- 분석 결과와 업무 제안은 구분해서 설명해야 한다.

### 분석 한계

- 추가한 고객과 주문 데이터는 학습용 가상 데이터다.
- orders 테이블에 상품 ID, 수량과 주문 금액이 없다.
- 고객별 주문 횟수는 분석할 수 있지만 매출 기여도와 수익성은 판단할 수 없다.
- 고객 가입일이 없어 가입 후 첫 주문까지 걸린 기간을 계산할 수 없다.
- 주문 취소 사유가 없어 취소 주문이 많은 원인을 직접 확인할 수 없다.
- 최근 30일과 60일 기준은 학습용 업무 규칙이다.
- 최근 주문 공백만으로 고객 이탈을 확정할 수 없다.
- 관리 대상 분류는 통계 검정이나 머신러닝 예측 결과가 아니다.
- 고객 연락과 캠페인의 실제 효과는 별도의 실험으로 검증해야 한다.

---

# Statistics

## Day 21 - 고객 주문 데이터 기술통계 분석

### 학습 주제

- 기술통계의 역할
- 모집단과 표본
- 모수와 통계량
- 변수의 종류와 측정 수준
- 평균
- 중앙값
- 최빈값
- 분산
- 표준편차
- 사분위수
- IQR
- 잠재적 이상치
- 히스토그램
- 상자그림
- pandas describe

### 사용 데이터

- 입력 파일: `outputs/customer_order_mini_project.csv`
- 데이터 출처: Day 20 확장 고객 주문 미니 프로젝트
- 분석 단위: 고객 1명당 1행
- 분석 고객 수: 30명

### 학습 내용

- 기술통계는 현재 데이터의 대표적인 수준과 분포를 요약하는 방법이라는 점을 학습했다.
- 모집단은 관심 대상 전체이고 표본은 실제로 관측한 일부라는 점을 구분했다.
- 숫자로 저장된 변수라도 customer_id처럼 식별자이면 평균 계산이 의미 없다는 점을 확인했다.
- 평균은 모든 값을 사용하지만 이상치에 민감하고, 중앙값은 극단값의 영향을 상대적으로 적게 받는다는 점을 비교했다.
- 가장 자주 나타나는 값인 최빈값을 계산했다.
- 분산과 표준편차를 이용해 고객 주문 수의 변동성을 확인했다.
- pandas의 var와 std는 기본적으로 표본 기준인 ddof=1을 사용한다는 점을 확인했다.
- Q1, 중앙값과 Q3를 계산하고 IQR을 구했다.
- IQR 하한과 상한을 이용해 잠재적 이상치를 확인했다.
- 잠재적 이상치는 자동 삭제 대상이 아니라 업무 맥락을 확인할 대상이라는 점을 학습했다.
- describe를 사용해 여러 수치 변수의 기본 통계량을 확인했다.
- 히스토그램으로 주문 수의 빈도 분포를 확인했다.
- 상자그림으로 관리 대상별 중앙값, IQR과 이상치를 비교했다.

### 주요 결과

- 전체 고객 수: 30명
- 평균 주문 수: 약 3.47건
- 중앙값: 3.5건
- 최빈값: 4건
- 표준편차: 약 2.37건
- Q1: 2건
- Q3: 5건
- IQR: 3건
- 최솟값: 0건
- 최댓값: 9건
- IQR 기준 잠재적 이상치: 0명

### 관리 대상별 주문 수

- activation_candidate 평균: 0건
- general_management 평균: 약 2.29건
- order_issue_review 평균: 4건
- reengagement_candidate 평균: 3.6건
- retention_priority 평균: 6건

### 결과 해석

전체 고객의 평균 주문 수와 중앙값이 비슷해
특정 고주문 고객 한 명이 전체 평균을 크게 왜곡하지는 않았다.

다만 주문 수는 0건에서 9건까지 분포하고 표준편차가 약 2.37건이므로
고객 간 주문 활동 차이는 존재한다.

전체 평균 주문 수만 사용하는 것보다 고객 관리 대상별 평균,
중앙값과 표준편차를 함께 확인하는 것이 고객 활동을 더 정확하게 설명한다.

### 생성 파일

- `notebooks/10_customer_order_descriptive_statistics.ipynb`
- `outputs/customer_order_descriptive_summary.csv`
- `outputs/customer_management_descriptive_summary.csv`
- `outputs/customer_order_count_histogram.png`
- `outputs/customer_order_count_boxplot.png`

### 수정 파일

- `README.md`
- `STUDY_LOG.md`

### 배운 점

- 평균 하나만으로 데이터의 전체 모습을 설명할 수 없다.
- 대표값과 함께 표준편차, 사분위수와 분포를 확인해야 한다.
- 평균과 중앙값의 차이는 분포의 치우침이나 이상치 영향을 확인하는 단서다.
- 표준편차가 크면 같은 평균을 가진 집단이라도 고객 경험이나 행동 차이가 클 수 있다.
- IQR 기준 밖의 값은 잠재적 이상치이며 자동으로 제거하면 안 된다.
- 기술통계는 데이터의 현재 모습을 설명하지만 원인이나 인과관계를 증명하지 않는다.

### 분석 한계

- 학습용 가상 데이터다.
- 고객 수가 30명으로 적다.
- 주문 금액과 상품 정보가 없다.
- 주문 횟수만으로 고객 가치를 판단할 수 없다.
- 고객군 차이의 통계적 유의성은 아직 검정하지 않았다.

---

## Day 22 - 고객 확률·조건부확률·확률분포 분석

### 학습 주제

- 표본공간과 사건
- 경험적 확률
- 여사건
- 교사건
- 합사건
- 조건부확률
- 독립
- 확률변수
- 경험적 확률분포
- 베르누이분포
- 이항분포
- 정규분포
- z점수

### 사용 데이터

- 입력 파일: `outputs/customer_order_mini_project.csv`
- 분석 단위: 고객 1명당 1행
- 전체 고객 수: 30명
- 데이터 출처: Day 20 SQL 고객 주문 미니 프로젝트

### 학습 내용

- 확률은 사건이 발생할 가능성을 0부터 1 사이의 값으로 표현한다는 점을 학습했다.
- 현재 데이터의 관측 빈도로 경험적 확률을 계산했다.
- 여사건은 관심 사건이 발생하지 않는 경우이며 두 확률의 합은 1이라는 점을 확인했다.
- 교사건은 두 사건이 동시에 발생하는 경우이고 합사건은 두 사건 중 하나 이상이 발생하는 경우라는 점을 구분했다.
- 조건부확률에서는 조건에 해당하는 고객만 분모로 사용한다는 점을 확인했다.
- P(A|B)와 P(B|A)는 분모가 다르기 때문에 같은 값이 아닐 수 있다는 점을 확인했다.
- 두 사건이 독립이라면 P(A|B)=P(A)이고 P(A∩B)=P(A)P(B)가 성립한다는 점을 학습했다.
- 불리언 열의 평균이 True 비율과 같다는 점을 활용해 고객 확률을 계산했다.
- 고객 주문 수를 이산확률변수로 보고 경험적 확률분포를 만들었다.
- 확률분포의 고객 수 합계와 확률 합계를 검증했다.
- 확률분포의 기댓값이 실제 주문 수 평균과 같다는 점을 확인했다.
- retention 여부를 0과 1의 베르누이 변수로 변환했다.
- 이항분포를 이용해 고객 5명 중 정확히 2명이 retention_priority일 확률을 계산했다.
- 주문 수의 z점수를 계산해 고객별 상대적 위치를 비교했다.
- 실제 주문 수 분포와 같은 평균·표준편차를 가진 정규곡선을 비교했다.
- 표준화는 데이터의 척도를 바꾸지만 정규분포로 변환하는 것은 아니라는 점을 학습했다.
- 조건부확률이 높다는 결과만으로 인과관계를 결론 내릴 수 없다는 점을 확인했다.

### 주요 확률 결과

- P(주문 이력 있음): 약 83.3%
- P(주문 이력 없음): 약 16.7%
- P(recent): 약 56.7%
- P(retention_priority): 30.0%
- P(VIP): 약 26.7%
- P(retention ∩ VIP): 약 23.3%
- P(retention ∪ VIP): 약 33.3%
- P(retention | VIP): 87.5%
- P(VIP | retention): 약 77.8%

### 독립 여부

P(retention_priority)는 30%였지만
P(retention_priority | VIP)는 87.5%였다.

또한 실제 P(retention ∩ VIP)는 약 23.3%였고,
독립을 가정한 P(retention) × P(VIP)는 약 8.0%였다.

따라서 현재 데이터에서 VIP와 retention_priority 사건은
독립으로 보기 어렵다.

다만 이 결과는 연관성을 보여줄 뿐
VIP 등급이 주문 활동을 증가시킨다는 인과관계를 증명하지 않는다.

### 확률분포 결과

- 고객 주문 수 범위: 0건~9건
- 가장 자주 나타난 주문 수: 4건
- P(주문 수=4): 20%
- 주문 수 기댓값: 약 3.47건
- 실제 주문 수 평균: 약 3.47건
- 최고 주문 고객 z점수: 약 2.33
- 평균 ±1표준편차 내 고객: 19명, 약 63.3%
- 평균 ±2표준편차 내 고객: 29명, 약 96.7%
- 평균 ±3표준편차 내 고객: 30명, 100%

### 생성 파일

- `notebooks/11_customer_probability_distribution_analysis.ipynb`
- `outputs/customer_probability_summary.csv`
- `outputs/customer_order_probability_distribution.csv`
- `outputs/customer_grade_conditional_probability.csv`
- `outputs/customer_order_zscore.csv`
- `outputs/customer_order_probability_distribution.png`
- `outputs/customer_retention_probability_by_grade.png`
- `outputs/customer_order_normal_comparison.png`

### 수정 파일

- `README.md`
- `STUDY_LOG.md`

### 배운 점

- 확률을 계산하기 전에 사건과 분모를 먼저 정의해야 한다.
- 조건부확률은 전체 고객이 아니라 조건에 해당하는 고객을 분모로 사용한다.
- P(A|B)와 P(B|A)는 서로 다른 질문이다.
- 불리언 값의 평균을 이용하면 비율을 간단하게 계산할 수 있다.
- 경험적 확률분포의 확률 합계는 1이어야 한다.
- 확률분포의 기댓값은 가중평균이며 실제 산술평균과 연결된다.
- 이항분포를 사용하려면 각 시행의 성공확률이 같고 독립이라는 가정이 필요하다.
- z점수는 상대적인 위치를 나타내지만 데이터가 정규분포라는 것을 보장하지 않는다.
- 조건부확률이 높아도 인과관계를 바로 주장하면 안 된다.

### 분석 한계

- 학습용 가상 데이터다.
- 고객 수가 30명으로 적다.
- 관측 확률을 실제 전체 고객 확률로 일반화할 수 없다.
- 등급별 고객 수가 다르다.
- 주문 수는 이산형이므로 정규분포가 정확한 모형은 아니다.
- 고객 등급과 주문 활동의 시간적 선후 관계를 확인하지 못했다.
- 상품, 구매금액과 가입기간이 없다.

---

## Day 23 - Customer Order Correlation Analysis

### 학습 주제

- 공분산
- Pearson 상관계수
- 양의 상관관계와 음의 상관관계
- 상관계수 행렬
- 산점도를 이용한 변수 관계 확인
- 구조적 상관관계
- 상관관계와 인과관계 구분

### 사용 데이터

- `outputs/customer_order_mini_project.csv`

### 학습 내용

고객 주문 데이터의 주요 수치형 변수 사이의 관계를
공분산과 Pearson 상관계수를 이용해 분석했다.

공분산은 두 변수가 평균을 기준으로
같은 방향 또는 반대 방향으로 움직이는지 보여주지만,
변수의 단위에 영향을 받기 때문에 관계의 강도를 직접 비교하기 어렵다.

Pearson 상관계수는 공분산을 두 변수의 표준편차로 나누어
-1에서 1 사이의 값으로 표준화한다.

상관계수만으로 관계를 판단하지 않고
산점도를 함께 확인했다.

또한 total_order_count와 paid_order_count처럼
변수 생성 구조에서 서로 연결된 관계와
실제 고객 행동에서 관찰할 가치가 있는 관계를 구분했다.

### 주요 결과

- total_order_count와 recency_days 상관계수: [실행 후 입력]
- total_order_count와 active_period_days 상관계수: [실행 후 입력]
- 기타 주요 관계: [실행 후 입력]

### 결과 해석

[실제 상관계수와 산점도를 확인한 뒤 직접 작성]

높은 상관계수가 나타났다고 해서
한 변수가 다른 변수의 원인이라고 판단하지 않았다.

특히 total_order_count,
paid_order_count,
cancelled_order_count는 계산 구조상 서로 연결되어 있으므로
높은 상관을 독립적인 고객 행동 인사이트로 해석하지 않았다.

### 생성 파일

- `notebooks/12_customer_order_correlation_analysis.ipynb`
- `outputs/customer_order_covariance_matrix.csv`
- `outputs/customer_order_correlation_matrix.csv`
- `outputs/customer_order_pair_correlation_summary.csv`
- `outputs/customer_order_count_correlation_bar.png`
- `outputs/customer_order_count_vs_recency.png`
- `outputs/customer_order_count_vs_active_period.png`

### 수정 파일

- `README.md`
- `STUDY_LOG.md`

### 배운 점

공분산은 두 변수의 공동 움직임 방향을 보여주지만
단위에 영향을 받는다.

Pearson 상관계수는 공분산을 표준화하여
변수 간 선형 관계의 방향과 정도를 비교할 수 있게 한다.

그러나 상관계수가 높아도
계산 구조, 제3의 변수, 역인과 등의 가능성이 있으므로
인과관계로 해석해서는 안 된다.

상관계수가 0에 가깝다는 것은
모든 관계가 없다는 뜻이 아니라
선형 관계가 약하다는 의미다.

### 분석 한계

현재 데이터는 고객 수가 많지 않은 가상 데이터이므로
상관계수가 일부 고객의 값에 영향을 받을 수 있다.

일부 변수는 동일한 주문 데이터에서 계산된 파생 변수이므로
구조적 상관관계가 존재한다.

또한 관찰 데이터이므로
현재 분석만으로 인과관계를 판단할 수 없다.

---

## Day 24 - Customer Order Sampling and Statistical Inference

### 학습 주제

- 추론통계
- 모집단과 표본
- 무작위 표본추출
- 표본분포
- 중심극한정리
- 표준편차와 표준오차
- 점추정
- 신뢰구간

### 사용 데이터

- `outputs/customer_order_mini_project.csv`

### 학습 내용

고객 주문 데이터를 이용하여
표본을 다시 추출할 때 평균 주문 수가 얼마나 달라지는지 확인했다.

pandas의 `sample()`을 이용해 무작위 표본을 추출하고,
같은 크기의 표본을 반복해서 추출하여
표본평균들의 분포인 표본분포를 만들었다.

표본평균의 분포는 개별 고객 주문 수의 분포와 다른 개념이며,
표본 크기가 충분해질수록 표본평균의 분포가
정규분포에 가까워지는 중심극한정리의 의미를 학습했다.

또한 개별 관측값의 퍼짐을 나타내는 표준편차와
평균 추정값의 흔들림을 나타내는 표준오차를 구분했다.

마지막으로 표본평균, 표준오차, t분포 임계값을 이용하여
평균 주문 수의 95% 신뢰구간을 계산했다.

### 주요 결과

- 연습용 모집단 평균: [실행 후 입력]
- 반복 표본평균의 평균: [실행 후 입력]
- 표본평균의 표준오차: [실행 후 입력]
- 평균 주문 수 점추정: [실행 후 입력]
- 95% 신뢰구간: [실행 후 입력]

### 결과 해석

표본을 다시 추출할 때마다 평균 주문 수는 달라질 수 있으며,
하나의 표본평균만으로 모집단 평균을 정확히 알 수는 없다.

표본 수가 증가할수록 표준오차가 작아져
평균 추정의 불확실성이 감소하는 것을 확인했다.

신뢰구간은 점추정값만 제시하는 것보다
추정의 불확실성을 함께 보여준다는 점에서 의미가 있다.

### 생성 파일

- `notebooks/13_customer_order_sampling_inference.ipynb`
- `outputs/customer_order_sample_means.csv`
- `outputs/customer_order_standard_error_by_sample_size.csv`
- `outputs/customer_order_inference_summary.csv`
- `outputs/customer_order_sampling_distribution.png`
- `outputs/customer_order_standard_error_by_sample_size.png`

### 수정 파일

- `README.md`
- `STUDY_LOG.md`

### 배운 점

표본평균은 표본을 어떻게 뽑느냐에 따라 달라질 수 있다.

표본분포는 원본 데이터의 분포가 아니라
반복해서 계산한 통계량의 분포다.

표준편차는 개별 데이터의 퍼짐을 나타내고,
표준오차는 표본통계량의 추정 불확실성을 나타낸다.

표본 수가 증가하면 표준오차는 감소하지만
표본이 편향되어 있다면 단순히 표본 수만 늘리는 것으로
대표성 문제가 해결되지 않는다.

### 분석 한계

현재 데이터는 실제 모집단에서 무작위 추출된 표본이 아니라
학습 목적으로 생성된 30명의 가상 고객 데이터다.

따라서 계산한 신뢰구간을 실제 고객 모집단에
일반화할 수 없다.

이번 분석은 추론통계의 계산 원리와
불확실성 해석을 이해하기 위한 실습이다.

---

## Day 25 - Customer Order Hypothesis Test

### 학습 주제

- 가설검정
- 귀무가설
- 대립가설
- p-value
- 유의수준
- 1종 오류
- 2종 오류
- 통계적 유의성
- 독립표본 t검정
- Welch t검정

### 사용 데이터

- `outputs/customer_order_mini_project.csv`

### 학습 내용

Day 24에서 학습한 표본 변동과 표준오차를 바탕으로,
관측된 집단 간 평균 차이가 단순한 표본 변동으로
설명될 수 있는지 판단하는 가설검정을 학습했다.

귀무가설은 두 집단의 평균 차이가 없다는 기준 가설이며,
대립가설은 두 집단의 평균이 다르다는 가설로 설정했다.

p-value는 귀무가설이 참이라는 가정 아래
현재 관측값과 같거나 더 극단적인 결과가 나타날 확률이라는
점을 학습했다.

VIP 고객과 Non-VIP 고객의 평균 주문 수를 비교하기 위해
Welch 독립표본 t검정을 수행했다.

두 집단의 분산이 같다고 확신할 근거가 없으므로
`equal_var=False`를 사용했다.

p-value뿐 아니라 각 그룹의 고객 수,
평균, 표준편차와 실제 평균 차이를 함께 확인했다.

### 주요 결과

- VIP 고객 수: 8
- Non-VIP 고객 수: 22
- VIP 평균 주문 수: 6
- Non-VIP 평균 주문 수: 2.5
- 평균 차이: 3.5
- t-statistic: 4.8
- p-value: 0.0002
- 검정 판단: 유의수준 0.05에서 귀무가설을 기각한다.

### 결과 해석

p-value가 유의수준보다 작을 경우
귀무가설을 기각하고,
그렇지 않을 경우 귀무가설을 기각하지 못한다고 표현했다.

귀무가설을 기각하지 못했다고
두 집단의 평균이 완전히 같다고 해석하지 않았다.

또한 통계적으로 유의한 결과가
업무적으로 큰 차이를 의미하는 것은 아니므로
실제 평균 차이도 함께 확인했다.

### 생성 파일

- `notebooks/14_customer_order_hypothesis_test.ipynb`
- `outputs/customer_grade_order_group_summary.csv`
- `outputs/customer_grade_order_ttest_result.csv`
- `outputs/customer_grade_order_mean_comparison.png`

### 수정 파일

- `README.md`
- `STUDY_LOG.md`

### 배운 점

가설검정은 처음부터 차이가 있다고 가정하는 것이 아니라
차이가 없다는 귀무가설을 기준으로
현재 데이터가 얼마나 이 가설과 양립 가능한지 평가한다.

p-value는 귀무가설이 참일 확률이나
결과가 우연일 확률이 아니다.

유의수준은 귀무가설을 기각할 판단 기준이며,
유의수준보다 작은 p-value가 관측되면
귀무가설과 데이터가 잘 맞지 않는다고 판단한다.

또한 통계적 유의성과 실제 효과의 크기는
서로 다른 개념이므로 함께 평가해야 한다.

### 분석 한계

현재 데이터는 30명의 학습용 가상 고객 데이터이며
실제 모집단에서 무작위 추출된 표본이 아니다.

VIP 고객 수가 작기 때문에
표본에 따른 결과 변동 가능성이 존재한다.

또한 고객 등급과 주문 행동 사이의 인과관계를
현재 관찰 데이터만으로 판단할 수 없다.

---

## Day 26 - Customer Categorical Independence Test

### 학습 주제

- 범주형 변수
- 교차표
- 관측빈도
- 기대빈도
- 독립
- 카이제곱 통계량
- 카이제곱 독립성 검정
- p-value
- 자유도
- 기대빈도 조건
- t검정과 카이제곱 검정 선택

### 사용 데이터

- `outputs/customer_order_mini_project.csv`

### 학습 내용

VIP 여부와 retention_priority 여부의 관계를
교차표와 카이제곱 독립성 검정으로 분석했다.

두 범주형 변수의 조합별 빈도를 확인하기 위해
`pd.crosstab()`을 사용하여 관측빈도표를 만들었다.

귀무가설은 VIP 여부와 retention 여부가
서로 독립이라는 것으로 설정했다.

두 변수가 독립이라고 가정했을 때 예상되는
기대빈도와 실제 관측빈도를 비교하고,
`chi2_contingency()`를 이용하여
카이제곱 통계량, p-value, 자유도와 기대빈도를 계산했다.

또한 p-value만 확인하지 않고
기대빈도가 지나치게 작은 셀이 존재하는지도 확인했다.

### 주요 결과

- chi-square: 13.6445
- p-value: 0.0002
- 자유도: 1
- 5보다 작은 기대빈도 셀 수: 1
- 검정 판단: 귀무가설 기각

### 결과 해석

VIP 여부와 Retention 여부가 독립이라는 유의미한 통계적 수치를 확인하지 못했다.

카이제곱 독립성 검정은
두 범주형 변수 사이의 빈도 분포가
독립 가정과 얼마나 다른지를 평가한다.

p-value뿐 아니라 기대빈도 조건도 함께 확인했다.

기대빈도가 작은 셀이 존재할 경우
소규모 표본에서 카이제곱 근사가 불안정할 수 있으므로
검정 결과를 강하게 해석하지 않았다.

### 생성 파일

- `notebooks/15_customer_categorical_independence_test.ipynb`
- `outputs/customer_vip_retention_observed.csv`
- `outputs/customer_vip_retention_expected.csv`
- `outputs/customer_vip_retention_chi_square_result.csv`
- `outputs/customer_vip_retention_count.png`

### 수정 파일

- `README.md`
- `STUDY_LOG.md`

### 배운 점

t검정은 수치형 변수의 평균을 비교하는 검정이고,
카이제곱 독립성 검정은 두 범주형 변수의
빈도 분포 사이의 연관성을 평가한다.

관측빈도는 실제 데이터에서 확인된 수이고,
기대빈도는 두 변수가 독립이라는 가정에서
예상되는 빈도다.

관측빈도와 기대빈도의 차이가 클수록
독립 가정과 잘 맞지 않을 가능성이 커진다.

또한 p-value가 작더라도
검정의 전제조건이 적절한지 먼저 확인해야 한다.

### 분석 한계

현재 데이터는 30명의 학습용 가상 고객 데이터이므로
여러 교차표 셀의 표본 수가 작을 수 있다.

기대빈도가 작은 경우 카이제곱 근사가 불안정할 수 있다.

또한 VIP 여부와 retention 여부 사이에
통계적 연관성이 관측되더라도
현재 관찰 데이터만으로 인과관계를 판단할 수 없다.

---

## Day 27 - Customer Machine Learning Foundation

### 학습 주제

- 머신러닝 기초
- 지도학습과 비지도학습
- 회귀와 분류
- Feature와 Target
- X와 y
- 예측 시점
- 데이터 누수
- Train/Test 데이터 분할
- stratify
- 기준선
- 과적합 기초

### 사용 데이터

- `outputs/customer_order_mini_project.csv`

### 학습 내용

기술통계와 추론통계 이후
새로운 관측값의 결과를 예측하는 머신러닝 단계에 진입했다.

예측하려는 Target이 연속적인 숫자이면 회귀,
범주이면 분류 문제라는 기준을 학습했다.

머신러닝에서 예측에 사용하는 입력 변수를 Feature,
예측해야 하는 정답을 Target이라고 하며
Python에서는 일반적으로 X와 y로 표현한다.

현재 retention_priority를 분류 Target으로 가정하고
머신러닝 문제로 사용할 수 있는지 검토했다.

retention_priority가 total_order_count,
recency_days 등의 현재 주문 정보를 이용해 만든 규칙이라는 점에서
이 변수들을 다시 Feature로 사용하는 경우
데이터 누수가 발생할 수 있음을 확인했다.

또한 train_test_split을 이용해
데이터를 Train과 Test로 분리하고,
stratify를 이용해 두 데이터의 Target 비율을
가능한 비슷하게 유지했다.

복잡한 모델을 만들기 전에
다수 클래스를 항상 예측하는 단순 기준선도 계산했다.

### 주요 결과

- 전체 고객 수: 30
- Train 고객 수: 22
- Test 고객 수: 8
- 전체 Retention 비율: 0.30
- Train Retention 비율: 0.32
- Test Retention 비율: 0.25
- 기준선 정확도: 0.75

### 결과 해석

현재 데이터는 머신러닝 학습 구조를 이해하기 위한
연습 데이터로는 사용할 수 있지만,
실전 예측 모델의 성능을 평가하기에는 한계가 있다.

고객 수가 적고 retention_priority가
실제 미래 결과가 아니라 현재 데이터를 이용해 만든
규칙 기반 Target이기 때문이다.

따라서 모델 성능을 억지로 계산하지 않고
Feature/Target 정의, 데이터 누수와 데이터 분할에 집중했다.

### 생성 파일

- `notebooks/16_customer_ml_foundation.ipynb`
- `outputs/customer_ml_feature_review.csv`
- `outputs/customer_ml_split_summary.csv`
- `outputs/customer_ml_baseline_summary.csv`
- `outputs/customer_ml_target_distribution.png`

### 수정 파일

- `README.md`
- `STUDY_LOG.md`

### 배운 점

머신러닝은 모델 종류를 먼저 고르는 것이 아니라
예측하려는 Target과 예측 시점을 먼저 정의해야 한다.

Feature에는 실제 예측 시점에 사용할 수 있는 정보만 포함해야 하며,
Target을 만드는 데 사용한 정보나 미래 정보를 포함하면
데이터 누수가 발생한다.

Train 데이터는 모델 학습에 사용하고,
Test 데이터는 학습 과정에서 보지 않은 데이터의
성능을 확인하는 데 사용한다.

분류에서는 stratify를 이용해
Train과 Test의 클래스 비율을 비슷하게 유지할 수 있다.

또한 모델 성능은 반드시 단순한 기준선과 비교해야 한다.

### 분석 한계

현재 데이터는 고객 30명 수준의 학습용 가상 데이터다.

retention_priority 역시 실제 미래 이탈 결과가 아닌
규칙 기반 관리 분류이므로
실전 머신러닝 Target으로 사용하기에는 한계가 있다.

향후 실제 예측 모델을 만들려면
더 많은 고객 데이터와 예측 시점 이후에 관측되는
미래 Target이 필요하다.

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
