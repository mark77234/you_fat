//
//  InputGenderView.swift
//  RudyMark
//
//  Created by 트루디 on 3/25/25.
//

import SwiftUI

struct InputGenderView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel: UserViewModel
    @State private var selectedGender: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("\(viewModel.name)님의\n성별을 알려주세요")
                .font(.setPretendard(weight: .bold, size: 25))
            
            Spacer()
            
            HStack(spacing: 30) {
                SelectableButton(imageName: "maleImage", isSelected: selectedGender == "남성") {
                    selectedGender = "남성"
                    viewModel.saveGender(true)
                }
                
                SelectableButton(imageName: "femaleImage", isSelected: selectedGender == "여성") {
                    selectedGender = "여성"
                    viewModel.saveGender(false)
                }
            }
            .padding(.vertical)
            
            Spacer()
            
            NextButton(isEnabled: selectedGender != nil, action: {
                viewModel.saveGender(viewModel.isMale)
                router.push(.InputDiabetesType)
            }, label: {
                Text("다음")
            })
            .padding(.bottom, 24)
            
        }
        .onAppear {
            selectedGender = viewModel.isMale ? "남성" : "여성"
        }
        .padding(.all, 40)
    }
}

//#Preview {
//    InputGenderView()
//}
