//
//  InputNameView.swift
//  RudyMark
//
//  Created by 트루디 on 4/29/25.
//

import SwiftUI

struct InputNameView: View {
    @EnvironmentObject var viewModel: UserViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("안녕하세요!\n어떻게 불러드리면 될까요?")
                .font(.setPretendard(weight: .bold, size: 25))
            
            Spacer()
            
            TextField("이름을 입력해주세요", text: $viewModel.name)
                .font(.setPretendard(weight: .semiBold, size: 32))
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black.opacity(0.32))
                
            Spacer()

            NextButton(isEnabled: true, action: {
                router.push(.InputBirth)
                viewModel.saveName(viewModel.name)
            }, label: {
                Text("다음")
            })
            .padding(.bottom, 24)
        }
        .padding(.all, 40)
    }
}
 
