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