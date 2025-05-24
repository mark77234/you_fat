//
//  CardContainerView.swift
//  RudyMark
//
//  Created by 트루디 on 5/24/25.
//

import SwiftUI

struct CardContainerView<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            content()
        }
        .padding(.all, 10)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.top, 15)
    }
}
