//
//  NotificationModel.swift
//  RudyMark
//
//  Created by 트루디 on 5/25/25.
//
import SwiftUI

enum NotificationType: String, CaseIterable, Identifiable {
    case bloodSugar = "혈당 알림"
    case meal = "식사 알림"
    case medication = "복약 알림"
    
    var displayName: String {
            switch self {
            case .bloodSugar: return "혈당 체크"
            case .meal: return "식사"
            case .medication: return "약 복용"
            }
        }
    var id: String { rawValue }
}

struct NotificationTime: Identifiable, Equatable {
    let id: UUID
    var hour: Int
    var minute: Int
    var isOn: Bool
    var type: NotificationType

    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"
        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        let date = Calendar.current.date(from: components) ?? Date()
        return formatter.string(from: date)
    }
}
