import SwiftUI

// MARK: - 메인 MainStatsView
struct MainStatsView: View {
    // 선택된 날짜에 대한 상태. 현재 날짜로 초기화하여 동적으로 시작할 수 있습니다.
    @State private var selectedDate: Date = {
        // 현재 날짜로 시작하려면 아래 주석 해제:
        // return Date()
        
        // 특정 날짜 (스크린샷 기준)로 시작하려면 아래 사용:
        var components = DateComponents()
        components.year = 2025
        components.month = 4
        components.day = 29
        return Calendar.current.date(from: components) ?? Date()
    }()
    
    var body: some View {
        NavigationView { // 잠재적인 내비게이션 바 항목을 위해 NavigationView 추가
            ScrollView { // 전체 콘텐츠 스크롤을 위해 ScrollView 사용
                VStack(spacing: 20) {
                    // StatusBarView 제거됨 (요청에 따라)
                    
                    // 헤더: 월 및 연도 선택기 (Date Picker 휠 드롭다운 포함)
                    MonthYearSelectorView(selectedDate: $selectedDate)
                    
                    // 달력 그리드 (날짜 탭 기능 포함)
                    CalendarView(selectedDate: $selectedDate)
                    
                    // 월별 미션 도전 프롬프트
                    MissionChallengePromptView()
                    
                    // 미션 목록
                    MissionListView()
                    
                    // 선택된 날짜 표시 (하단에 당일 날짜가 적히도록)
                    SelectedDateDisplayView(selectedDate: $selectedDate)
                    
                    Spacer() // 콘텐츠를 상단으로 밀어올림
                }
                .padding(.horizontal, 20) // 전체 콘텐츠에 가로 패딩 추가
            }
            .navigationBarHidden(true) // 기본 내비게이션 바 숨기기 (사용자 정의 바 사용)
            .background(Color.white.edgesIgnoringSafeArea(.all)) // 배경색 설정
        }
    }
}

// MARK: - CalendarDay 모델
struct CalendarDay: Identifiable {
    let id = UUID()
    let dayNumber: Int
    let isCurrentMonth: Bool // 현재 표시되는 월에 속하는지
    var isSelected: Bool = false // 사용자가 탭하여 선택한 날짜인지
    var isHighlighted: Bool = false // 미션 등으로 강조 표시되는 날짜인지 (스크린샷의 연보라색 원)
}

// MARK: - CalendarView (날짜 탭 기능 포함)
struct CalendarView: View {
    @Binding var selectedDate: Date
    
    // 한국어 요일 이름
    let weekdayNames = ["일", "월", "화", "수", "목", "금", "토"]
    
    // 주어진 월과 연도에 대한 달력 날짜를 생성하는 함수
    private func generateCalendarDays(for date: Date) -> [CalendarDay] {
        var days: [CalendarDay] = []
        let calendar = Calendar.current
        
        // 해당 월의 첫째 날에 대한 구성 요소 가져오기
        guard let monthFirstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) else {
            return []
        }
        
        // 해당 월의 첫째 날의 요일 가져오기 (일요일은 1, 토요일은 7)
        let weekdayOfFirstDay = calendar.component(.weekday, from: monthFirstDay) // 1-부터 시작 (일요일 = 1)
        
        // 이전 달에서 표시할 날짜 수 결정 (달력 그리드를 채우기 위함)
        let leadingEmptyCells = weekdayOfFirstDay - 1
        
        // 이전 달의 마지막 날짜 가져오기 (이전 달의 날짜를 표시하기 위함)
        guard let previousMonth = calendar.date(byAdding: .month, value: -1, to: monthFirstDay) else {
            return []
        }
        let numberOfDaysInPreviousMonth = calendar.range(of: .day, in: .month, for: previousMonth)?.count ?? 0
        
        // 이전 달의 선행 날짜 추가
        for i in 0..<leadingEmptyCells {
            days.append(CalendarDay(dayNumber: numberOfDaysInPreviousMonth - leadingEmptyCells + 1 + i, isCurrentMonth: false))
        }
        
        // 현재 달의 날짜 추가
        guard let rangeOfDaysInMonth = calendar.range(of: .day, in: .month, for: date) else {
            return []
        }
        let numberOfDaysInCurrentMonth = rangeOfDaysInMonth.count
        
        for day in 1...numberOfDaysInCurrentMonth {
            var isHighlighted = false
            // 스크린샷을 기반으로 2025년 4월의 특정 날짜들을 강조 표시
            // (1-19, 21-25, 27-28일)
            if calendar.component(.year, from: date) == 2025 && calendar.component(.month, from: date) == 4 {
                if (1...19).contains(day) || (21...25).contains(day) || (27...28).contains(day) {
                    isHighlighted = true
                }
            }
            // 현재 `selectedDate`의 일(day)이 이 `day`와 같고, 월/년도 같다면 `isSelected`를 true로 설정
            let currentDayComponents = calendar.dateComponents([.year, .month, .day], from: date)
            let selectedDayComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
            
            let isCurrentlySelected = (currentDayComponents.year == selectedDayComponents.year &&
                                       currentDayComponents.month == selectedDayComponents.month &&
                                       day == selectedDayComponents.day)
            
            days.append(CalendarDay(dayNumber: day, isCurrentMonth: true, isSelected: isCurrentlySelected, isHighlighted: isHighlighted))
        }
        
        // 그리드를 채우기 위해 다음 달의 후행 날짜 추가 (총 42칸)
        let trailingEmptyCells = 42 - days.count
        for i in 1...trailingEmptyCells {
            days.append(CalendarDay(dayNumber: i, isCurrentMonth: false))
        }
        
        // 스크린샷에는 6개의 행 (총 42일)이 표시되므로 42개로 고정
        return Array(days.prefix(42))
    }
    
    var body: some View {
        let days = generateCalendarDays(for: selectedDate)
        
        VStack(spacing: 10) {
            // 요일 헤더
            HStack {
                ForEach(weekdayNames, id: \.self) { weekday in
                    Text(weekday)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // 달력 그리드
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(days) { day in
                    ZStack {
                        // 미션 등으로 강조 표시되는 연보라색 원 (isHighlighted)
                        if day.isHighlighted {
                            Circle()
                                .fill(Color.purple.opacity(0.1)) // 강조 표시된 날짜에 대한 연한 보라색
                                .frame(width: 35, height: 35)
                        }
                        
                        // 사용자가 탭하여 선택한 날짜에 대한 보라색 테두리 (isSelected)
                        if day.isSelected {
                            Circle()
                                .stroke(Color.purple, lineWidth: 2) // 선택된 날짜에 대한 보라색 테두리
                                .frame(width: 45, height: 45) // 선택된 날짜에 대한 더 큰 원
                        }
                        
                        Text("\(day.dayNumber)")
                            .font(.system(size: 17, weight: day.isSelected ? .bold : .regular))
                            .foregroundColor(day.isCurrentMonth ? .black : .gray.opacity(0.6)) // 현재 월이 아니면 흐리게
                            .frame(width: 45, height: 45) // 정렬을 위해 모든 텍스트가 동일한 공간을 차지하도록 보장
                    }
                    .contentShape(Circle()) // 탭 가능한 영역을 원형으로 설정
                    .onTapGesture {
                        // 현재 월의 날짜만 탭하여 선택 가능하게 함
                        if day.isCurrentMonth {
                            var components = Calendar.current.dateComponents([.year, .month], from: selectedDate)
                            components.day = day.dayNumber
                            selectedDate = Calendar.current.date(from: components) ?? selectedDate
                        }
                    }
                }
            }
        }
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
        )
    }
}

// MARK: - MissionChallengePromptView
struct MissionChallengePromptView: View {
    var body: some View {
        HStack {
            Text("이번 달 미션에 도전해볼까요?")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            // 에셋 이름이 "grape_monster"라고 가정
            Image("grape_monster")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35, height: 35)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(red: 0.5, green: 0.3, blue: 0.7)) // 스크린샷의 보라색
        )
        .padding(.vertical, 10)
    }
}

// MARK: - Mission 모델
struct Mission: Identifiable {
    let id = UUID()
    let name: String
    let status: String
    let iconName: String // 예: "grape_icon"
    let statusColor: Color
}

// MARK: - MissionCardView
struct MissionCardView: View {
    let mission: Mission
    
    var body: some View {
        HStack {
            // 에셋 이름이 "grape_icon"이라고 가정
            Image("grape_icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundColor(Color(red: 0.5, green: 0.3, blue: 0.7)) // 포도색
            
            Text(mission.name)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.black)
            
            Spacer()
            
            Text(mission.status)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(mission.statusColor)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
        )
    }
}

// MARK: - MissionListView
struct MissionListView: View {
    let missions: [Mission] = [
        Mission(name: "포도알 모으기", status: "25 / 30", iconName: "grape_icon", statusColor: Color.gray),
        Mission(name: "단디하자!", status: "14일째", iconName: "grape_icon", statusColor: Color.gray),
        Mission(name: "혈당 스파이크 10회 미만", status: "완수중", iconName: "grape_icon", statusColor: Color(red: 0.5, green: 0.3, blue: 0.7)) // "완수중"에 대한 보라색
    ]
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(missions) { mission in
                MissionCardView(mission: mission)
            }
        }
    }
}

// MARK: - SelectedDateDisplayView (선택된 날짜를 하단에 표시)
struct SelectedDateDisplayView: View {
    @Binding var selectedDate: Date
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 (E)" // 예: "2025년 4월 29일 (화)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
    
    var body: some View {
        Text("선택된 날짜: \(dateFormatter.string(from: selectedDate))")
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.black)
            .padding(.top, 10)
    }
}


// MARK: - 미리보기 제공자
struct MainStatsView_Previews: PreviewProvider {
    static var previews: some View {
        MainStatsView()
    }
}
