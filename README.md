#  단디(Dan-D) - 당(단)뇨 + D(Diabetes) 단디 챙겨라

##  프로젝트 개요
- 프로젝트 설명: 당뇨환자의 식단관리 및 혈당측정 기록 앱
- 주요 기능: 일일 식사,혈당 측정 및 기록하고 AI 조언 및 분석 기능
- 프레임워크: `SwiftUI`
- 사용 언어: `Swift`
- 아키텍쳐: `MVVM (Model-View-ViewModel)`
- 지원버전: `iOS 18.0`

##  폴더 구조
```cmd
RudyMark/
├── Font/
│   ├── Pretendard-Black
│   └── ...
├── Models/            # View에서 사용하는 데이터 모델 정의
│   └── (예: Food, Diabetes, Users 등등 . . .)
├── Resources/        
│   └── Database/foodData.csv
│   ├── Fonts/ ...
│   └── Extensions/ ...
├── Utils/        
│   └── CSVImporter.csv
├── ViewModels/        # 페이지별 ViewModel 파일 (비즈니스 로직 처리)
│   ├── HomeViewModel.swift
│   ├── RecordViewModel.swift
│   ├── StatsViewModel.swift
│   └── MoreViewModel.swift
├── Views/             # SwiftUI로 구성된 UI 파일
│   ├── Common/        # 자주 쓰이는 컴포넌트
│   │     ├── CardView.swift
│   │     └── ...
│   ├── Home/       
│   │     ├── HomeView.swift
│   │     ├── HomeCards/FoodCard
│   │     └── HomeCards/ ...
│   ├── Record/       
│   │     ├── RecordView.swift
│   │     ├── Record/FoodCard
│   │     ├── BloodCard/ ...
│   │     └── FoodCard/ ...
│   ├── Stats/       
│   │     ├── StatsView.swift
│   │     └── ...
│   ├── More/       
│   │     ├── MoreView.swift
│   │     └── ...
```

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


## 주요 기능
### 사용자 정보

- 이름, 성별, 키, 몸무게 기본정보를 받고
- 당뇨환자 정보도 추가로 입력받음

<img src="https://github.com/user-attachments/assets/3df6b0e2-f7c9-4ee4-8249-f911123f5c6b" width=20%>
<img src="https://github.com/user-attachments/assets/ff061079-c6e6-476f-a659-9ffc8b7a19b4" width=20%>
<img src="https://github.com/user-attachments/assets/48c7bc3a-c04a-466e-8d65-3c0075a6ed2e" width=20%>
<img src="https://github.com/user-attachments/assets/3de3a7df-6a51-4704-bb49-144f362ddee9" width=20%>

### 홈 화면
- 식사 및 혈당 기록 정보 확인
- AI 일일조언

<img src="https://github.com/user-attachments/assets/59c552df-7a98-4d2c-98c5-d5f559e541c1" width=20%>
<img src="https://github.com/user-attachments/assets/3df0ed83-abba-42ab-9211-ee4f92050ba0" width=20%>
<img src="https://github.com/user-attachments/assets/ac833eaf-b06f-4065-a2ef-48b786594553" width=20%>


### 식사 및 혈당 기록

- 혈당 기록

<img src="https://github.com/user-attachments/assets/3300d91c-f669-4040-af88-925e3213d775" width=20%>
<img src="https://github.com/user-attachments/assets/1b3217ce-57ef-4cc0-b339-e6bab656ae4b" width=20%>

- 음식 기록

<img src="https://github.com/user-attachments/assets/ebc25822-5b2c-4b9e-9073-7692c2ea515d" width=20%>
<img src="https://github.com/user-attachments/assets/ac4b0bbc-769d-48e2-94e6-1e00ab407926" width=20%>
<img src="https://github.com/user-attachments/assets/df877f0d-cffd-47c2-a702-45c8c6e84656" width=20%>

### 통계

<img src="https://github.com/user-attachments/assets/d1e734b6-d6ff-48b5-8481-821e164a366b" width=20%>
<img src="https://github.com/user-attachments/assets/f0011a86-037c-4378-a68e-9179825ec075" width=20%>

### 설정

<img src="https://github.com/user-attachments/assets/ec52b593-8641-458f-b664-668ef044848d" width=20%>
<img src="https://github.com/user-attachments/assets/b29b92fb-8928-487e-ab21-81cb60af926e" width=20%>
<img src="https://github.com/user-attachments/assets/7568c28b-ac91-4dd6-8478-69f8b19d4d32" width=20%>

- 휴대폰 알림

<img src="https://github.com/user-attachments/assets/31fbc866-d9b2-4d2c-ac3f-8ee434b8a0ee" width=20%>
<img src="https://github.com/user-attachments/assets/a69117ad-b983-4c8e-ba12-5174826c0283" width=20%>
<img src="https://github.com/user-attachments/assets/3e8ec3ed-015f-42d0-ae39-c7f3067c9848" width=20%>


  
