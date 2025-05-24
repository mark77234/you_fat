//
//  NotificationSetViewModel.swift
//  RudyMark
//
//  Created by 트루디 on 5/25/25.
//


import Foundation

class NotificationSetViewModel: ObservableObject {
    @Published var bloodSugarOn: Bool = true
    @Published var mealOn: Bool = true
    @Published var medicationOn: Bool = false

    func isTypeVisible(_ type: NotificationType) -> Bool {
        switch type {
        case .bloodSugar:
            return true
        case .meal:
            return true
        case .medication:
            return mealOn
        }
    }
}
