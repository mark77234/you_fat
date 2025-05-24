//
//  FirstInputView.swift
//  RudyMark
//
//  Created by 트루디 on 3/25/25.
//
import SwiftUI

struct FirstInputView: View {
    @StateObject var router = Router()
    @StateObject var viewModel = UserViewModel()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            InputNameView()
                .navigationDestination(for: Screen.self) { screen in
                    switch screen {
                    case .InputBody: InputBodyView()
                    case .InputGender: InputGenderView()
                    case .InputPillTime: InputPillTimeView()
                    case .InputBloodTime: InputBloodTimeView()
                    case .Home: TabBar()
                    case .InputName: InputNameView()
                    case .InputBirth: InputBirthView()
                    case .InputDiabetesType: InputDiabetesTypeView()
                    }
                }
        }
        .environmentObject(router) // 여기 선언해야 자식뷰에 일일이 넘겨주지 않아도 됨
        .environmentObject(viewModel)
    }
}
