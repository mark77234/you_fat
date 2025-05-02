//
//  InputBodyView.swift
//  RudyMark
//
//  Created by 트루디 on 3/25/25.
//

import SwiftUI

struct InputBodyView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel: UserViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(viewModel.name)님의\n키와 몸무게를 알려주세요")
                .font(.setPretendard(weight: .bold, size: 25))
            
            Spacer()
            
            VStack(spacing: 30) { // 입력 필드 그룹
                InputField(title: "키 (cm)", text: $viewModel.height)
                InputField(title: "몸무게 (kg)", text: $viewModel.weight)
            }
            .padding(.top, -30)
            
            Spacer()
            
            // NextButton
            NextButton(isEnabled: viewModel.height != "0.0" && viewModel.weight != "0.0") {
                viewModel.saveWeight(viewModel.weight)
                viewModel.saveHeight(viewModel.height)
                router.push(.InputGender)
            } label: {
                HStack {
                    Text("다음")
                    Image(systemName: "arrow.right")
                }
            }
            .padding(.bottom, 24)
        }
        .padding(.all, 40)
        
    }
}

struct InputField: View {
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.setPretendard(weight: .medium, size: 24))
                .foregroundStyle(.grayFont2)
            TextField(title, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.semiBlue, lineWidth: 1.5) // 테두리 색과 두께
                )
        }
    }
}

//#Preview {
//    let router = Router()  // ✅ 라우터 인스턴스 생성
//    return NavigationStack {
//        InputBodyView()
//            .environmentObject(router)  // ✅ 환경 객체로 라우터 전달
//    }
//}
