//
//  InputPillTimeView.swift
//  RudyMark
//
//  Created by 트루디 on 3/25/25.
//

import SwiftUI

struct InputPillTimeView: View {
    
    @EnvironmentObject var router: Router
    
    @State private var progress = 25.0
    @State private var selectedOption = "시간 선택"
    let options = ["2시간 후", "1시간 후", "30분 후", "식후 즉시"]
    
    
    var body: some View {
        ZStack {
            Color.skyblue.ignoresSafeArea()
            
            VStack(spacing: 20) {
                ProgressbarView(progress: progress)
                    .onAppear {
                        progress = 50.0
                    }
                
                Text("복약 시간")
                    .frame(alignment: .leading)
                    .font(.title2).fontWeight(.bold)
                
                HStack{
                    Text("식사 후 몇 시간 뒤에 약을 복용하시나요?")
                        .font(.system(size: 15))
                        .padding(.leading, 3)
                    Spacer()
                }
                
                // 복약 시간 선택 뷰
                Menu {
                    ForEach(options, id: \.self) { option in
                        Button(action: { selectedOption = option }) {
                            Text(option)
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedOption)
                            .foregroundStyle(.black)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                }
                
                NextButton(isEnabled: true, action: {
                    router.push(.InputBloodTime)
                }, label: {
                    Text("다음")
                })
                
            }
            .padding(.horizontal, 24)
            .frame(height: 315/852 * UIScreen.main.bounds.height)
            .background(Color(.white).cornerRadius(20))
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    InputPillTimeView()
}
