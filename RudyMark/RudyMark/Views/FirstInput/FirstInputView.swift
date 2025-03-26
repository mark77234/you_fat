//
//  FirstInputView.swift
//  RudyMark
//
//  Created by 트루디 on 3/25/25.
//
import SwiftUI

struct FirstInputView: View {
    @StateObject var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            InputBodyView()
                .navigationDestination(for: Screen.self) { screen in
                    switch screen {
                    case .InputBody: InputBodyView()
                    case .InputGender: InputGenderView()
                    case .InputPillTime: InputPillTimeView()
                    case .InputBloodTime: InputBloodTimeView()
                    case .Home: HomeView()
                    }
                }
        }
        .environmentObject(router)
    }
}
