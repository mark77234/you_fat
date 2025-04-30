//
//  InputNameView.swift
//  RudyMark
//
//  Created by 트루디 on 4/29/25.
//

import SwiftUI

struct InputNameView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("안녕하세요!\n어떻게 불러드리면 될까요?")
                .font(.setPretendard(weight: .extraBold, size: 25))
            
        }
    }
}
#Preview {
    InputNameView()
}
