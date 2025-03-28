//
//  InputBloodTimeView.swift
//  RudyMark
//
//  Created by 트루디 on 3/25/25.
//

import SwiftUI

struct InputBloodTimeView: View {
    @EnvironmentObject var router: Router
    
    @State private var progress = 50.0
    @State private var selectedTimes: Set<String> = []
    
    let timeSlots = ["오전 6시-9시", "오전 9시-12시", "오후 12시-3시", "오후 3시-6시", "오후 6시-9시", "그 외 시간"]
    
    var body: some View {
        ZStack {
            Color.skyblue.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                ProgressbarView(progress: progress)
                    .onAppear {
                        progress = 75.0
                    }
                    .padding(.vertical)
                    .padding(.top)
                
                
                VStack(spacing: 26) {
                    Text("혈당 체크 시간")
                        .font(.title2).fontWeight(.bold)
                    
                    Text("선호하는 혈당 체크 시간대를 2개 이상 선택해주세요")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                }
                .padding(.vertical)
                VStack{
                    // 시간 선택 버튼들
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                        ForEach(timeSlots, id: \.self) { time in
                            Button(action: {
                                if selectedTimes.contains(time) {
                                    selectedTimes.remove(time)
                                } else {
                                    selectedTimes.insert(time)
                                }
                            }) {
                                Text(time)
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
                    router.popToRoot() // 모든 뷰를 pop하여 처음 화면으로 이동
                    router.push(.Home)
                }) {
                    Text("완료")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedTimes.count >= 2 ? .primaryGreen : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(selectedTimes.count < 2)
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 24)
            .frame(height: 466/852 * UIScreen.main.bounds.height)
            .background(Color(.white).cornerRadius(20))
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    InputBloodTimeView()
}
