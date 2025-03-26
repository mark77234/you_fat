//
//  SelectableButton.swift
//  RudyMark
//
//  Created by 트루디 on 3/26/25.
//
import SwiftUI

struct SelectableButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .frame(maxWidth: .infinity, minHeight: 50)
                .foregroundStyle(.black)
                .background(isSelected ? .primaryGreen.opacity(0.3) : Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        }
    }
}
