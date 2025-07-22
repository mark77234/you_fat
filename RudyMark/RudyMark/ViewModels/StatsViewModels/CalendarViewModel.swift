//
//  CalendarViewModel.swift
//  RudyMark
//
//  Created by 트루디 on 7/3/25.
//

import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var selectedDate: Date
    @Published var days: [CalendarDay] = []

    // MonthYearSelectorView 관련
    @Published var showPicker = false
    @Published var currentYear: Int
    @Published var currentMonth: Int

    private let calendar = Calendar.current

    init(initialDate: Date = Date()) {
        self.selectedDate = initialDate
        self.currentYear = calendar.component(.year, from: initialDate)
        self.currentMonth = calendar.component(.month, from: initialDate)
        generateCalendar(for: initialDate)
    }

    func generateCalendar(for date: Date) {
        var newDays: [CalendarDay] = []

        guard let monthFirstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) else { return }
        let weekdayOfFirstDay = calendar.component(.weekday, from: monthFirstDay)
        let leadingEmptyCells = weekdayOfFirstDay - 1

        if let previousMonth = calendar.date(byAdding: .month, value: -1, to: monthFirstDay),
           let numberOfDaysInPreviousMonth = calendar.range(of: .day, in: .month, for: previousMonth)?.count {
            for i in 0..<leadingEmptyCells {
                newDays.append(CalendarDay(dayNumber: numberOfDaysInPreviousMonth - leadingEmptyCells + 1 + i, isCurrentMonth: false, isSelected: false, isHighlighted: false))
            }
        }

        guard let rangeOfDays = calendar.range(of: .day, in: .month, for: date) else { return }
        let selectedComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        let currentComponents = calendar.dateComponents([.year, .month], from: date)

        for day in rangeOfDays {
            let isSelected = (currentComponents.year == selectedComponents.year &&
                              currentComponents.month == selectedComponents.month &&
                              day == selectedComponents.day)

            let isHighlighted = (currentComponents.year == 2025 && currentComponents.month == 4 &&
                ((1...19).contains(day) || (21...25).contains(day) || (27...28).contains(day)))

            newDays.append(CalendarDay(dayNumber: day, isCurrentMonth: true, isSelected: isSelected, isHighlighted: isHighlighted))
        }

        let trailing = 42 - newDays.count
        for i in 1...trailing {
            newDays.append(CalendarDay(dayNumber: i, isCurrentMonth: false, isSelected: false, isHighlighted: false))
        }

        days = newDays
    }

    func select(_ day: CalendarDay) {
        guard day.isCurrentMonth else { return }
        var components = calendar.dateComponents([.year, .month], from: selectedDate)
        components.day = day.dayNumber
        selectedDate = calendar.date(from: components) ?? selectedDate
        generateCalendar(for: selectedDate)
    }

    // 년/월 선택 관련
    func updateDate() {
        var components = DateComponents()
        components.year = currentYear
        components.month = currentMonth
        components.day = 1

        if let newDate = calendar.date(from: components) {
            selectedDate = newDate
            generateCalendar(for: newDate)
        }
    }

    func syncWithSelectedDate() {
        currentYear = calendar.component(.year, from: selectedDate)
        currentMonth = calendar.component(.month, from: selectedDate)
    }

    var years: [Int] {
        let now = calendar.component(.year, from: Date())
        return Array(now - 10 ... now + 10)
    }

    var months: [Int] {
        Array(1...12)
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: selectedDate)
    }

    var yearFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = false
        formatter.numberStyle = .none
        return formatter
    }
}
