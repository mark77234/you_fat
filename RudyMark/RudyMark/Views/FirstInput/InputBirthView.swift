//
//  InputBirthView.swift
//  RudyMark
//
//  Created by 트루디 on 4/30/25.
//
import SwiftUI

struct InputBirthView: View {
    @EnvironmentObject var viewModel: BodyInformViewModel
    @EnvironmentObject var router: Router

    var body: some View {
        VStack {
            Text(String(viewModel.name ?? "이름"))
            NextButton(isEnabled: viewModel.name != nil, action: {
                router.push(.InputBody)
            }, label: {
                Text("다음")
            })
        }
    }
}
