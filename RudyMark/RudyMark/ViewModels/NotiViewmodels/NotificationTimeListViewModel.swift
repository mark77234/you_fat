//
//  NotificationTimeListViewModel.swift
//  RudyMark
//
//  Created by 트루디 on 5/25/25.
//


import Foundation

class NotificationTimeListViewModel: ObservableObject {
    @Published var times: [NotificationTime] = []

    func times(for type: NotificationType) -> [NotificationTime] {
        times.filter { $0.type == type }
    }
    
    func printAll() {
        print("📋 현재 알림 목록:")
        for time in times {
            print("⏰ \(time.formattedTime), 켜짐: \(time.isOn), id: \(time.id)")
        }
    }
    
    func toggle(_ id: UUID) {
        if let index = times.firstIndex(where: { $0.id == id }) {
            times[index].isOn.toggle()
        }
    }
    func add(time: NotificationTime) {
        print("✅ add() 호출됨: \(time.formattedTime)")
        times.append(time)
        printAll()
    }

    func update(_ time: NotificationTime) {
        print("✅ update() 호출됨: \(time.formattedTime)")
        if let index = times.firstIndex(where: { $0.id == time.id }) {
            times[index] = time
        } else {
            print("➕ 기존 항목 없음 → 새로 추가")
            times.append(time)
        }
        printAll()
    }

    func delete(_ id: UUID) {
        print("✅ delete() 호출됨")
        times.removeAll { $0.id == id }
        printAll()
    }
}
