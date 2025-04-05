//
//  MoreIcon.swift
//  RudyMark
//
//  Created by 이병찬 on 4/3/25.
//
import SwiftUI

struct MoreIcon: View {
    let iconName: String
    let label: String
    let action: () -> Void

    var body: some View {
        VStack {
            Button(action: action) {
                Image(systemName: iconName)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.primary)
            }
            Text(label)
                .font(.caption)
        }
    }
}
