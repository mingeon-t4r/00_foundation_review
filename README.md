# Foundation Review

## 목적
기존에 학습한 Python 문법과 pandas merge를 이용해
고객·주문 데이터의 매출 구조를 분석한다.

## 분석 질문
1. 전체 매출과 주문 수는 얼마인가?
2. 고객별 매출 차이는 어떠한가? 
3. 지역별 매출은 어떻게 구성되는가? 
4. 어떤 고객을 우선 관리해야 하는가? 

## 사용 기술
- Python
- pandas
- matplotlib
- SQLite 기초 SQL
- Git

## 데이터 단위
- customers: 고객 1명당 1행
- orders: 주문 1건당 1행

## 실행 순서
1. `01_python_basics_rebuild.ipynb`
2. `02_customer_order_analysis.ipynb`

## 주요 결과
- 전체 매출: 890,000원
- 주문 수: 6건
- 고객 수: 3명
- 매출 상위 고객: Park
- 매출 상위 지역: Seoul

## 한계
- 예제 데이터로 실제 시장을 대표하지 않는다.
- 고객 수와 주문 수가 작다.
- 날짜 정보가 없어 월별 추세와 재구매 기간을 분석할 수 없다.

## 다음 학습
- pandas groupby·pivot_table
- SQL GROUP BY
- SQL JOIN
- 결측치·중복 데이터 정제