//
//  TimeCardView.swift
//  RudyMark
//
//  Created by 이병찬 on 5/24/25.
//
import SwiftUI


struct TimeCardView: View {
    let currentTime: String
    
    var body: some View {
        Text(currentTime)
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .foregroundColor(.gray)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}


func formattedCurrentTime() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy년 M월 d일 a h:mm"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: Date())
}
