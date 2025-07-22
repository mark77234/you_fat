//
//  CalendarDayView.swift
//  RudyMark
//
//  Created by 트루디 on 7/3/25.
//

import SwiftUI

struct CalendarDayView: View {
    let day: CalendarDay
    let onTap: () -> Void
    
    var body: some View {
        ZStack {
            if day.isHighlighted {
                Circle()
                    .fill(Color.primaryPurple.opacity(0.2))
                    .frame(width: 35/852 * UIScreen.main.bounds.height,
                           height: 35/852 * UIScreen.main.bounds.height)
            }
            
            if day.isSelected {
                ZStack {
                    if day.isHighlighted {
                        Circle().stroke(Color.primaryPurple, lineWidth: 3)
                    } else {
                        Circle().fill(Color.primaryPurple.opacity(0.2))
                        Circle().stroke(Color.primaryPurple, lineWidth: 3)
                    }
                }
                .frame(width: 45/852 * UIScreen.main.bounds.height,
                       height: 45/852 * UIScreen.main.bounds.height)
            }
            
            Text("\(day.dayNumber)")
                .font(.system(size: 17, weight: day.isSelected ? .bold : .regular))
                .foregroundColor(day.isCurrentMonth ? .black : .gray.opacity(0.6))
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
        VStack(spacing: 10) {
            HStack {
                ForEach(weekdayNames, id: \.self) { weekday in
                    Text(weekday)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            
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
        .onAppear {
            viewModel.generateCalendar(for: viewModel.selectedDate)
        }
    }
}
