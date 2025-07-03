//
//  ProfileSetting.swift
//  RudyMark
//
//  Created by 이병찬 on 4/3/25.
//

import SwiftUI

struct ProfileSettingView: View {
    @EnvironmentObject private var viewModel: UserViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var tempName: String = ""
    @State private var tempHeight: String = ""
    @State private var tempWeight: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            
            Image("basicProfile")
                .resizable()
                .scaledToFit()
                .frame(width: 92)
            
            LabeledTextField(title: "이름", text: $tempName, placeholder: "이름을 입력하세요")
            LabeledTextField(title: "키(cm)", text: $tempHeight, keyboardType: .decimalPad, placeholder: "예: 160")
            LabeledTextField(title: "몸무게(kg)", text: $tempWeight, keyboardType: .decimalPad, placeholder: "예: 55")
            
            Spacer()
            
        }.onAppear {
            tempName = viewModel.name
            tempHeight = viewModel.height
            tempWeight = viewModel.weight
        }
        .toolbar {
            // 저장 버튼
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewModel.name = tempName
                    viewModel.height = tempHeight
                    viewModel.weight = tempWeight
                    dismiss()
                }, label: {
                    Text("저장")
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                })
            }
        }
        .padding()
        .navigationTitle("내 정보")
        .background(Color.skyblue.ignoresSafeArea())
    }
}

#Preview {
    let viewModel = UserViewModel()
    return ProfileSettingView()
        .environmentObject(viewModel)
}

struct LabeledTextField: View {
    let title: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var placeholder: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.setPretendard(weight: .regular, size: 14))
                .foregroundStyle(.black)
            
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .padding(12)
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
        }
    }
}
