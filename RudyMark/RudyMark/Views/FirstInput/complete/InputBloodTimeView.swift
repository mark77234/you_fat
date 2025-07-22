//
//  InputBloodTimeView.swift
//  RudyMark
//
//  Created by 트루디 on 3/25/25.
//

import SwiftUI

struct InputBloodTimeView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false

    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel: UserViewModel
    
    @State private var selectedTimes: Set<GlucoseCheckTime> = []
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                
                Text("\(viewModel.name)님의\n혈당 체크 시간을 알려주세요")
                    .font(.setPretendard(weight: .bold, size: 25))
                
                Text("선호하는 혈당 체크 시간대를\n2개 이상 선택해주세요")
                    .font(.setPretendard(weight: .medium, size: 18))
                    .foregroundStyle(.gray)
                
                    .padding(.vertical)
                VStack{
                    // 시간 선택 버튼들
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                        ForEach(GlucoseCheckTime.allCases) { time in
                            Button(action: {
                                if selectedTimes.contains(time) {
                                    selectedTimes.remove(time)
                                } else {
                                    selectedTimes.insert(time)
                                }
                            }) {
                                Text(time.rawValue)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(selectedTimes.contains(time) ? Color.primaryGreen.opacity(0.3) : Color.white)
                                    .foregroundStyle(.black)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                
                Spacer()
                
                // 다음 버튼 (2개 이상 선택해야 활성화)
                Button(action: {
                    viewModel.saveGlucoseCheckTime(Array(selectedTimes))
                    router.setStack([.InputGender, .Home])
                    hasSeenOnboarding = true
                }) {
                    Text("완료")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedTimes.count >= 2 ? .primaryGreen : Color.gray)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }
                .disabled(selectedTimes.count < 2)
                .padding(.bottom, 24)
            }
            .onAppear{
                selectedTimes = Set(viewModel.glucoseCheckTime)
            }
            .padding(.all, 40)
        }
    }
}
