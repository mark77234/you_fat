//
//  SugarStatsViewModel.swift
//  RudyMark
//
//  Created by 트루디 on 4/2/25.
//

import SwiftUI

class SugarStatsViewModel: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var weeklyData: [(day: String, value: Int)] = []
    
    init() {
        fetchWeeklyData(for: selectedDate)
    }
    
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: selectedDate)
    }
    
    func changeDate(by days: Int) {
        selectedDate = Calendar.current.date(byAdding: .day, value: days, to: selectedDate) ?? selectedDate
        fetchWeeklyData(for: selectedDate)
    }
    
    func getWeeklyData(for date: Date) -> [(day: String, calories: Int)] {
        // 날짜에 맞는 데이터를 불러오는 로직 (예제)
        return [
            ("월", 150), ("화", 180), ("수", 160), ("목", 190), ("금", 200), ("토", 170), ("일", 140)
        ]
    }
    
    private func fetchWeeklyData(for date: Date) {
        // 예제 데이터 (실제 앱에서는 CoreData 또는 API 연동)
        self.weeklyData = [
            ("월", 150), ("화", 180), ("수", 160),
            ("목", 190), ("금", 200), ("토", 170), ("일", 140)
        ]
    }
}
