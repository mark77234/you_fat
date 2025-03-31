//
//  ProgressbarView.swift
//  RudyMark
//
//  Created by 트루디 on 3/25/25.
//

import SwiftUI

struct ProgressbarView: View {
    var progress: Double // 0 to 100
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.gray.opacity(0.3))
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: geometry.size.width * (progress / 100))
                    .foregroundStyle(.primaryGreen)
                    .animation(.easeInOut(duration: 1), value: progress)
            }
        }
        .frame(height: 15)
    }
}

#Preview {
    ProgressbarView(progress: 55)
}
