# Python 오류 기록

## 오류 1 — 숫자로 변환할 수 없는 문자열

- 날짜: 2026-07-25
- 학습 주제: 자료형 변환과 예외 처리
- 오류 유형: ValueError

### 오류가 발생한 코드

```python
try:
    price = int("12,000원")
except ValueError as error:
    print("변환 오류:", error)
```

### 오류 메시지

```text
변환 오류: invalid literal for int() with base 10: '12,000원'
```

### 원인

`int()`는 정수 형태의 문자열만 숫자로 변환할 수 있다.

`"12,000원"`에는 숫자가 아닌 쉼표 `,`와 문자 `"원"`이 포함되어 있어서 정수로 바로 변환할 수 없다.

### 해결한 코드

```python
raw_price = "12,000원"

clean_price = (
    raw_price
    .replace(",", "")
    .replace("원", "")
    .strip()
)

price = int(clean_price)

print(price)
```

### 실행 결과

```text
12000
```

### 배운 점

문자열을 숫자로 변환하기 전에는 쉼표, 단위, 공백 등 숫자가 아닌 문자를 먼저 제거해야 한다.

`try-except`는 오류로 프로그램이 중단되는 것을 막지만, 오류의 원인 자체를 해결하는 것은 아니다.


## 오류 2 — src 모듈을 찾지 못함

- 날짜: 2026-07-25
- 학습 주제: 사용자 정의 함수 파일 불러오기
- 오류 유형: ModuleNotFoundError

### 오류가 발생한 코드

```python
from src.kpi_utils import (
    calculate_average,
    classify_customer,
    calculate_growth
)
```

### 오류 메시지

```text
ModuleNotFoundError: No module named 'src'
```

### 원인

Python이 현재 실행 위치에서 `src` 폴더를 찾지 못했다.

Notebook이 프로젝트 최상위 폴더가 아니라 `notebooks` 폴더를 기준으로
실행되고 있거나, `src/kpi_utils.py` 파일이 실제로 생성·저장되지 않았을
가능성이 있다.

### 확인 코드

```python
from pathlib import Path

print("현재 실행 위치:", Path.cwd())
print("현재 위치에 src:", (Path.cwd() / "src").exists())
print("상위 위치에 src:", (Path.cwd().parent / "src").exists())
```

### 해결 방법

프로젝트 구조를 다음과 같이 정리했다.

```text
python-data-study/
├─ notebooks/
│  └─ day12.ipynb
├─ src/
│  ├─ __init__.py
│  └─ kpi_utils.py
└─ notes/
   └─ error_log.md
```

Notebook이 `notebooks` 폴더 기준으로 실행될 때 프로젝트 루트를
Python 경로에 추가했다.

```python
from pathlib import Path
import sys

project_root = Path.cwd().parent
sys.path.insert(0, str(project_root))

from src.kpi_utils import (
    calculate_average,
    classify_customer,
    calculate_growth
)
```

### 확인 결과

```python
print(calculate_average([100, 200, 300]))
print(classify_customer(350000))
print(calculate_growth(120000, 100000))
```

```text
200.0
VIP
0.2
```

### 배운 점

`import`할 때 Python은 현재 실행 위치와 Python 검색 경로에서 모듈을
찾는다. 파일이 존재하더라도 프로젝트 최상위 폴더가 검색 경로에 없으면
`ModuleNotFoundError`가 발생할 수 있다.

Notebook 파일의 위치와 실제 실행 기준 경로는 구분해서 확인해야 한다.

## 오류 3 — Matplotlib에서 잘못된 색상명 사용

- 날짜: 2026-07-27
- 학습 주제: matplotlib 그래프 작성 및 결과 저장
- 오류 유형: ValueError

### 오류가 발생한 코드

```python
plt.figtext(
    0.5,
    0.01,
    "서울 고객의 매출 비중이 가장 높지만, 고객 수와 주문 수가 함께 많기 때문에 고객당 매출도 별도로 확인해야 한다.",
    ha="center",
    fontsize=10,
    color="bule"
)
```

### 오류 메시지

```text
ValueError: 'bule' is not a valid value for color
```

### 원인

`plt.figtext()`의 `color` 인자에 유효하지 않은 색상명인 `"bule"`을
입력했다.

파란색을 의미하는 올바른 영문 표기는 `"blue"`이지만, 철자를
`"bule"`로 잘못 작성하여 Matplotlib이 해당 값을 색상으로 인식하지
못했다.

오류 메시지의 마지막 줄에서 다음 내용을 확인할 수 있었다.

```text
'bule' is not a valid value for color
```

### 확인 코드

Matplotlib이 특정 문자열을 올바른 색상으로 인식하는지 다음 코드로
확인할 수 있다.

```python
from matplotlib.colors import is_color_like

print(is_color_like("bule"))
print(is_color_like("blue"))
```

```text
False
True
```

### 해결 방법

잘못 작성한 색상명 `"bule"`을 `"blue"`로 수정했다.

```python
plt.figtext(
    0.5,
    0.01,
    "서울 고객의 매출 비중이 가장 높지만, 고객 수와 주문 수가 함께 많기 때문에 고객당 매출도 별도로 확인해야 한다.",
    ha="center",
    fontsize=10,
    color="blue"
)
```

한글이 그래프에서 깨지는 경고도 함께 발생했기 때문에 Windows의
한글 폰트인 `Malgun Gothic`을 설정했다.

```python
import matplotlib.pyplot as plt

plt.rcParams["font.family"] = "Malgun Gothic"
plt.rcParams["axes.unicode_minus"] = False
```

전체 수정 코드는 다음과 같다.

```python
from pathlib import Path
import matplotlib.pyplot as plt

# 한글 폰트 설정
plt.rcParams["font.family"] = "Malgun Gothic"
plt.rcParams["axes.unicode_minus"] = False

# 저장할 폴더와 파일 경로
output_path = Path("../outputs/region_sales.png")
output_path.parent.mkdir(parents=True, exist_ok=True)

# 그래프 생성
ax = region_summary.plot(
    x="region",
    y="total_sales",
    kind="bar",
    legend=False,
    figsize=(8, 6)
)

ax.set_title("지역별 총매출")
ax.set_xlabel("지역")
ax.set_ylabel("총매출")

fig = ax.get_figure()

fig.text(
    0.5,
    0.02,
    "서울 고객의 매출 비중이 가장 높지만, 고객 수와 주문 수가 함께 많기 때문에\n"
    "고객당 매출도 별도로 확인해야 한다.",
    ha="center",
    fontsize=10,
    color="blue"
)

fig.tight_layout(rect=[0, 0.10, 1, 1])
fig.savefig(output_path, dpi=150, bbox_inches="tight")

plt.show()
```

### 확인 결과

다음 코드로 저장 파일이 정상적으로 생성되었는지 확인했다.

```python
print(output_path.exists())
print(output_path)
```

```text
True
..\outputs\region_sales.png
```

그래프가 정상적으로 출력되었고 다음 항목을 확인했다.

```text
- ValueError가 더 이상 발생하지 않음
- 그래프 제목과 축 이름이 한글로 정상 표시됨
- 설명 문장이 파란색으로 표시됨
- outputs/region_sales.png 파일이 정상 생성됨
- 그래프 아래의 설명 문장이 잘리지 않음
```

### 추가 경고

오류와 함께 다음과 같은 경고가 발생했다.

```text
UserWarning: Glyph ... missing from font(s) DejaVu Sans
```

이 메시지는 프로그램 실행을 중단시키는 오류가 아니라
Matplotlib의 기본 폰트인 `DejaVu Sans`가 한글 글자를 지원하지 않아
발생한 경고다.

다음 설정으로 해결했다.

```python
plt.rcParams["font.family"] = "Malgun Gothic"
plt.rcParams["axes.unicode_minus"] = False
```

### 배운 점

함수의 인자에 문자열 값을 전달할 때는 해당 라이브러리가 허용하는
값인지 확인해야 한다. 단순한 철자 오류도 유효하지 않은 값으로
판단되어 `ValueError`가 발생할 수 있다.

오류 메시지는 마지막 줄부터 확인하면 핵심 원인을 빠르게 찾을 수
있다. 이번 오류에서는 다음 문장이 직접적인 원인을 알려주었다.

```text
'bule' is not a valid value for color
```

또한 `ValueError`와 `UserWarning`은 구분해야 한다.

- `ValueError`: 코드 실행을 중단시킨 실제 오류
- `UserWarning`: 실행은 가능하지만 한글 표시 문제가 생길 수 있다는 경고

그래프를 저장할 때는 색상뿐만 아니라 한글 폰트, 저장 폴더의 존재
여부, 설명 문장의 잘림 여부도 함께 확인해야 한다.