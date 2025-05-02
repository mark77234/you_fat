//
//  InputBirthView.swift
//  RudyMark
//
//  Created by 트루디 on 4/30/25.
//
import SwiftUI

struct InputBirthView: View {
    @EnvironmentObject var viewModel: UserViewModel
    @EnvironmentObject var router: Router

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(viewModel.name)님의\n생일을 알려주세요")
                .font(.setPretendard(weight: .bold, size: 25))
            
            Spacer()
            
            DatePicker("생년월일", selection:  $viewModel.birth, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .environment(\.locale, .init(identifier: "ko_KR"))
                
            Spacer()

            NextButton(isEnabled: true, action: {
                viewModel.saveBirth(viewModel.birth) // 생년월일 저장
                router.push(.InputBody)// 다음 화면은 키 몸무게 입력
            }, label: {
                Text("다음")
            })
            .padding(.bottom, 24)
        }
        .padding(.all, 40)
    }
}
