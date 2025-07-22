//
//  MonthYearSelectorView.swift
//  RudyMark
//
//  Created by 트루디 on 7/3/25.
//
import SwiftUI

struct MonthYearSelectorView: View {
    @Binding var selectedDate: Date
    @State private var showPicker = false
    
    @State private var currentYear: Int
    @State private var currentMonth: Int
    
    init(selectedDate: Binding<Date>) {
        _selectedDate = selectedDate
        let calendar = Calendar.current
        _currentYear = State(initialValue: calendar.component(.year, from: selectedDate.wrappedValue))
        _currentMonth = State(initialValue: calendar.component(.month, from: selectedDate.wrappedValue))
    }
    
    private var years: [Int] {
        let currentYear = Calendar.current.component(.year, from: Date())
        return Array(currentYear - 10 ... currentYear + 10)
    }
    
    private var months: [Int] {
        Array(1...12)
    }
    
    private var dateFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateFormat = "yyyy년 M월"
        f.locale = Locale(identifier: "ko_KR")
        return f
    }
    private var yearFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = false // 쉼표 사용 안 함
        formatter.numberStyle = .none // 숫자 스타일 (없음)
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                let calendar = Calendar.current
                currentYear = calendar.component(.year, from: selectedDate)
                currentMonth = calendar.component(.month, from: selectedDate)
                withAnimation(.smooth(duration: 0.5)) { // ✅ 이 줄 추가
                        showPicker.toggle()
                    }            }) {
                HStack {
                    Spacer()
                    Text(dateFormatter.string(from: selectedDate))
                        .foregroundColor(.primary)
                    Image(systemName: showPicker ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .semibold))
                    Spacer()
                }
                .padding()
            }
            
            if showPicker {
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        Picker("Year", selection: $currentYear) {
                            ForEach(years, id: \.self) { year in
                                Text("\(yearFormatter.string(from: NSNumber(value: year)) ?? "\(year)")년")
                                    .tag(year)
                            }
                        }
                        .pickerStyle(.wheel)
                        .labelsHidden()
                        .frame(width: 150)
                        
                        Picker("Month", selection: $currentMonth) {
                            ForEach(months, id: \.self) { month in
                                Text("\(month)월").tag(month)
                            }
                        }
                        .pickerStyle(.wheel)
                        .labelsHidden()
                        .frame(width: 100)
                        Spacer()
                    }
                    .frame(height: 200)
                    
                    Button(action: {
                        var components = DateComponents()
                        components.year = currentYear
                        components.month = currentMonth
                        components.day = 1
                        
                        if let newDate = Calendar.current.date(from: components) {
                            selectedDate = newDate
                        }
                        showPicker = false
                    }) {
                        Text("완료")
                            .font(.system(size: 16, weight: .semibold))
                            .padding()
                            .foregroundStyle(.purple)
                    }
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .padding(.horizontal)
    }
}
