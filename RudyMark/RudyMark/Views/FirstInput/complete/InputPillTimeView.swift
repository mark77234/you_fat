//
//  InputPillTimeView.swift
//  RudyMark
//
//  Created by 트루디 on 3/25/25.
//

import SwiftUI

struct InputPillTimeView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel: UserViewModel
    
    @State private var selectedOption: MedicationTiming = .immediately
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                
                Text("\(viewModel.name)님의\n복약 시간을 알려주세요")
                    .font(.setPretendard(weight: .bold, size: 25))
                
                Text("식사 후 몇 시간 뒤에\n약을 복용하시나요?")
                    .font(.setPretendard(weight: .medium, size: 18))
                    .padding(.vertical)
                
                // 복약 시간 선택 뷰
                Menu {
                    ForEach(MedicationTiming.allCases, id: \.self) { option in
                        Button(action: { selectedOption = option }) {
                            Text(option.rawValue)
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedOption.rawValue)
                            .foregroundStyle(.black)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundStyle(.gray)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                }
                .padding(.top, 10)
                
                Spacer()
                
                NextButton(isEnabled: true, action: {
                    viewModel.saveMedicationTiming(selectedOption)
                    router.push(.InputBloodTime)
                }, label: {
                    Text("다음")
                })
                .padding(.bottom, 24)
                
            }
            .onAppear{
                selectedOption = viewModel.medicationTiming
            }
            .padding(.all, 40)
        }
    }
}

#Preview {
    InputPillTimeView()
}
