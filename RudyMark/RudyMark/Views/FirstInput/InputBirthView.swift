//
//  InputBirthView.swift
//  RudyMark
//
//  Created by 트루디 on 4/30/25.
//
import SwiftUI

struct InputBirthView: View {
    @EnvironmentObject var viewModel: UserViewModel
    @EnvironmentObject var router: Router

    var body: some View {
        VStack {
            Text(String(viewModel.name))
            NextButton(isEnabled: true, action: {
                router.push(.InputBody)
            }, label: {
                Text("다음")
            })
        }
    }
}
