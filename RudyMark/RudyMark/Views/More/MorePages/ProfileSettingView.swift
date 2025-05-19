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
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.purple)
            
            TextField("이름", text: $viewModel.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("키(cm)", text: $viewModel.height)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("몸무게(kg)", text: $viewModel.weight)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Picker("성별", selection: $viewModel.isMale) {
                Text("남성").tag(true)
                Text("여성").tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Spacer()
            
            Button("저장") {
                viewModel.save()
                dismiss()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .padding()
        .navigationTitle("내 정보")
    }
}

#Preview {
    let viewModel = UserViewModel()
    return ProfileSettingView()
        .environmentObject(viewModel)
}
