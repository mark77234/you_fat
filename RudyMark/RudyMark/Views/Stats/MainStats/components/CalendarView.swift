//
//  CalendarDayView.swift
//  RudyMark
//
//  Created by 트루디 on 7/3/25.
//

import SwiftUI

// 아래 CalendarView 를 위한 뷰 분리
struct CalendarDayView: View {
    let day: CalendarDay
    let onTap: () -> Void
    
    var body: some View {
        ZStack {
            // 기록 있을 때 연보라색 색 채우기
            if day.isHighlighted {
                Circle()
                    .fill(Color.primaryPurple.opacity(0.2))
                    .frame(width: 35/852 * UIScreen.main.bounds.height,
                           height: 35/852 * UIScreen.main.bounds.height)
            }
            
            if day.isSelected {
                Circle().stroke(Color.primaryPurple, lineWidth: 3)
                    .frame(width: 45/852 * UIScreen.main.bounds.height,
                           height: 45/852 * UIScreen.main.bounds.height)
            }
            
            Text("\(day.dayNumber)")
                .font(.setPretendard(weight: day.isSelected ? .bold : .regular, size: 14))
                .foregroundStyle(.black)
                .frame(width: 45/852 * UIScreen.main.bounds.height,
                       height: 45/852 * UIScreen.main.bounds.height)
        }
        .contentShape(Circle())
        .onTapGesture {
            onTap()
        }
    }
}

struct CalendarView: View {
    @ObservedObject var viewModel: CalendarViewModel
    
    let weekdayNames = ["일", "월", "화", "수", "목", "금", "토"]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(weekdayNames, id: \.self) { weekday in
                    Text(weekday)
                        .font(.setPretendard(weight: .bold, size: 15))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 18)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(viewModel.days) { day in
                    CalendarDayView(day: day) {
                        viewModel.select(day)
                    }
                }
            }
        }
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
        )
    }
}

#Preview {
    CalendarView(viewModel: CalendarViewModel())
}
