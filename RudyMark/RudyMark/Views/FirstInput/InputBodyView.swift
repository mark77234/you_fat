//
//  InputBodyView.swift
//  RudyMark
//
//  Created by 트루디 on 3/25/25.
//

import SwiftUI

struct InputBodyView: View {
    @EnvironmentObject var router: Router
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var progress = 10.0
    
    var body: some View {
        ZStack {
            Color.skyblue.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ProgressbarView(progress: progress)
                    .padding(.vertical)
                    .padding(.top)
                
                Text("신체 정보")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 26)
                
                Spacer()
                
                VStack(spacing: 30) { // 입력 필드 그룹
                    InputField(title: "키 (cm)", text: $height)
                    InputField(title: "몸무게 (kg)", text: $weight)
                }
                .padding(.top, -30)
                
                Spacer()
                
                // NextButton
                NextButton(isEnabled: !height.isEmpty && !weight.isEmpty) {
                    print("다음 버튼 클릭됨")
                    router.push(.InputGender)
                } label: {
                    HStack {
                        Text("다음")
                        Image(systemName: "arrow.right")
                    }
                }
                .padding(.bottom, 24)
                
            }
            .padding(.horizontal, 24)
            .frame(height: 466/852 * UIScreen.main.bounds.height)
            .background(Color(.white).cornerRadius(20))
            .padding(.horizontal, 24)
            
        }
    }
}

struct InputField: View {
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 15))
                .foregroundStyle(.gray)
            TextField(title, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
        }
    }
}

#Preview {
    let router = Router()  // ✅ 라우터 인스턴스 생성
    return NavigationStack {
        InputBodyView()
            .environmentObject(router)  // ✅ 환경 객체로 라우터 전달
    }
}
