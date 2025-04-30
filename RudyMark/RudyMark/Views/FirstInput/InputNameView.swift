//
//  InputNameView.swift
//  RudyMark
//
//  Created by 트루디 on 4/29/25.
//

import SwiftUI

struct InputNameView: View {
    @EnvironmentObject var viewModel: BodyInformViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("안녕하세요!\n어떻게 불러드리면 될까요?")
                .font(.setPretendard(weight: .extraBold, size: 25))
            
            Spacer()
            TextField("이름을 입력해주세요", text: Binding(
                get: { viewModel.name ?? "" },
                set: { viewModel.name = $0 }
            ))
                .font(.system(size: 20))
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)

            Spacer()

            NextButton(isEnabled: viewModel.name != nil, action: {
                router.push(.InputBirth)
            }, label: {
                Text("다음")
            })
            .padding(.bottom, 24)
        }
        .padding(.all, 20)
    }
}
