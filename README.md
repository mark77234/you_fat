#  단디(Dan-D) - 당(단)뇨 + D(Diabetes) 단디 챙겨라

##  프로젝트 개요
- 프로젝트 설명: 당뇨환자의 식단관리 및 혈당측정 기록 앱
- 주요 기능: 일일 식사,혈당 측정 및 기록하고 AI 조언 및 분석 기능
- 프레임워크: `SwiftUI`
- 사용 언어: `Swift`
- 아키텍쳐: `MVVM (Model-View-ViewModel)`
- 지원버전: `iOS 18.0`

##  폴더 구조
RudyMark/
├── Models/            # View에서 사용하는 데이터 모델 정의
│   └── (예: Food, Diabetes, Users 등등 . . .)
├── ViewModels/        # 페이지별 ViewModel 파일 (비즈니스 로직 처리)
│   ├── HomeViewModel.swift
│   ├── RecordViewModel.swift
│   ├── StatsViewModel.swift
│   └── MoreViewModel.swift
├── Views/             # SwiftUI로 구성된 UI 파일
│   ├── Home/HomeView.swift
│   ├── Record/RecordView.swift
│   ├── Stats/StatsView.swift
│   └── More/MoreView.swift
├── Resources/         # 앱에서 사용하는 리소스 파일 (에셋, CSV 등)
│   └── Database/
│       └── foodData.csv
├── Services/          # API 통신 및 공통 기능 처리
│   └── CSVImporter.swift (+ API/ )

## 네이밍 컨벤션
### 클래스, 구조체, ENUM(열거형), 프로토콜
```cmd
PascalCase
```
### 변수 및 함수
- 명칭 명확하게 작성
```cmd
lowerCamelCase
```

## 개발 가이드라인
- 폴더 구조 유지(MVVM)
- 네이밍 컨벤션 준수
- PR 시 코드 리뷰 필수
