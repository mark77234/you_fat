//
//  NextButton.swift
//  RudyMark
//
//  Created by 트루디 on 3/25/25.
//


import SwiftUI

struct NextButton<Content: View>: View {
    
    let label: Content
    let action: () -> Void
    let isEnabled: Bool
    
    init(isEnabled: Bool, action: @escaping () -> Void, @ViewBuilder label: () -> Content) {
        self.isEnabled = isEnabled
        self.label = label()
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            if isEnabled {
                action()
            }
        }) {
            label
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 53)
                .background(isEnabled ? .primaryGreen:.gray)
                .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .disabled(!isEnabled) // 버튼이 비활성화된 경우 터치가 불가능하게 설정
    }
}

#Preview {
    NextButton(isEnabled: false, action: {print("")}, label: {
        Text("다음")
    })
}
