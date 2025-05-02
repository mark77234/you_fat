//
//  SelectableButton.swift
//  RudyMark
//
//  Created by 트루디 on 3/26/25.
//
import SwiftUI

struct SelectableButton: View {
    let imageName: String
    
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 128)
            }
            .frame(maxWidth: .infinity)
            .background(isSelected ? Color.primaryGreen.opacity(0.3) : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
