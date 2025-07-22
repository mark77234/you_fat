import SwiftUI

// MARK: - 메인 MainStatsView
struct MainStatsView: View {
    @StateObject private var viewModel = CalendarViewModel()
    // 선택된 날짜에 대한 상태. 현재 날짜로 초기화하여 동적으로 시작할 수 있습니다.
    
    var body: some View {
        NavigationView { // 잠재적인 내비게이션 바 항목을 위해 NavigationView 추가
            ScrollView { // 전체 콘텐츠 스크롤을 위해 ScrollView 사용
                VStack(spacing: 20) {
                    // StatusBarView 제거됨 (요청에 따라)
                    
                    // 헤더: 월 및 연도 선택기 (Date Picker 휠 드롭다운 포함)
                    MonthYearSelectorView(viewModel: viewModel)
                    
                    // 달력 그리드 (날짜 탭 기능 포함)
                    CalendarView(viewModel: viewModel)
                        .padding(.horizontal, 20)
                    
                    // 월별 미션 도전 프롬프트
                    MissionChallengePromptView()
                    
                    // 미션 목록
                    MissionListView()
                        .padding(.horizontal, 21)
                    
                    // 선택된 날짜 표시 (하단에 당일 날짜가 적히도록)
                    SelectedDateDisplayView(viewModel: viewModel)
                    
                    Spacer() // 콘텐츠를 상단으로 밀어올림
                }
            }
            .navigationBarHidden(true) // 기본 내비게이션 바 숨기기 (사용자 정의 바 사용)
            .background(Color.white.edgesIgnoringSafeArea(.all)) // 배경색 설정
        }
    }
}

// MARK: - MissionChallengePromptView
struct MissionChallengePromptView: View {
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            
            Text("이번 달 미션")
                .font(.setPretendard(weight: .bold, size: 18))
                .foregroundStyle(.black)
            Text("에 도전해볼까요?")
                .font(.setPretendard(weight: .semiBold, size: 18))
            
            Image("popoHi")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 29, height: 29)
            
            Spacer()
        }
        .padding()
        .background(
            Rectangle()
                .fill(Color.primaryPurple.opacity(0.2)) // 스크린샷의 보라색
        )
        .frame(height: 55)
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
            Image("grapes")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)
            
            Text(mission.name)
                .font(.setPretendard(weight: .semiBold, size: 18))
                .foregroundStyle(.black)
            
            Spacer()
            
            Text(mission.status)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(mission.statusColor)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.moreLightPurple)
                .shadow(color: Color.black.opacity(0.25), radius: 4.24, x: 0, y: 1)
                .frame(height: 63)
        )
    }
}

// MARK: - MissionListView
struct MissionListView: View {
    let missions: [Mission] = [
        Mission(name: "포도알 모으기", status: "25 / 30", iconName: "grape_icon", statusColor: Color.black),
        Mission(name: "단디하자!", status: "14일째", iconName: "grape_icon", statusColor: Color.black),
        Mission(name: "혈당 스파이크 10회 미만", status: "완수중", iconName: "grape_icon", statusColor: Color.lightGray)
    ]
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(missions) { mission in
                MissionCardView(mission: mission)
                    .padding(.bottom, 13)
            }
        }
    }
}

// MARK: - SelectedDateDisplayView (선택된 날짜를 하단에 표시)
struct SelectedDateDisplayView: View {
    @ObservedObject var viewModel: CalendarViewModel
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 (E)" // 예: "2025년 4월 29일 (화)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
    
    var body: some View {
        Text("선택된 날짜: \(dateFormatter.string(from: viewModel.selectedDate))")
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(.black)
            .padding(.top, 10)
    }
}


// MARK: - 미리보기 제공자
struct MainStatsView_Previews: PreviewProvider {
    static var previews: some View {
        MainStatsView()
    }
}
