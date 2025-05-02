//
//  InputDiabetesTypeView.swift
//  RudyMark
//
//  Created by 트루디 on 4/30/25.
//

import SwiftUI

struct InputDiabetesTypeView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel: UserViewModel
    @State private var selectedType: DiabetesType = .type1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(viewModel.name)님의\n당뇨 유형을 알려주세요")
                .font(.setPretendard(weight: .bold, size: 25))
            
            Spacer()
            
            SelectableTextButton(title: "1형", isSelected: selectedType == .type1) {
                selectedType = .type1
            }
            .padding(.vertical, 13)
            
            SelectableTextButton(title: "2형", isSelected: selectedType == .type2) {
                selectedType = .type2
            }
            .padding(.vertical, 13)
            
            SelectableTextButton(title: "임신성 당뇨", isSelected: selectedType == .gestational) {
                selectedType = .gestational
            }
            .padding(.vertical, 13)
            
            SelectableTextButton(title: "기타(유전, 노화 등)", isSelected: selectedType == .other) {
                selectedType = .other
            }
            .padding(.vertical, 13)
            
            Spacer()
            
            NextButton(isEnabled: true, action: {
                viewModel.saveDiabetesType(selectedType)
                router.push(.InputPillTime)
            }, label: {
                Text("다음")
            })
            .padding(.bottom, 24)
        }
        .onAppear {
            selectedType = viewModel.diabetesType
        }
        .padding(.all, 40)
    }
}

#Preview {
    let router = Router()
    let viewModel = UserViewModel()
    InputDiabetesTypeView()
        .environmentObject(router)
        .environmentObject(viewModel)
}

import SwiftUI

struct SelectableTextButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isSelected ? Color.green.opacity(0.2) : .white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.semiBlue, lineWidth: 1.5)
                )
        }
    }
}
