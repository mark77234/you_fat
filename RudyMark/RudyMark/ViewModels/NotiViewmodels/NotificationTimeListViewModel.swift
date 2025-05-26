//
//  NotificationTimeListViewModel.swift
//  RudyMark
//
//  Created by 트루디 on 5/25/25.
//


import Foundation

class NotificationTimeListViewModel: ObservableObject {
    @Published var times: [NotificationTime] = []
    
    init() {
        load()
    }
    
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
        guard let index = times.firstIndex(where: { $0.id == id }) else { return }
        times[index].isOn.toggle()
        
        let time = times[index]
        if time.isOn {
            LocalNotificationManager.shared.scheduleNotification(for: time, type: time.type)
        } else {
            LocalNotificationManager.shared.removeNotification(id: time.id)
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
        save()
    }
    
    func delete(_ id: UUID) {
        print("✅ delete() 호출됨")
        times.removeAll { $0.id == id }
        printAll()
        save()
    }
    
    private let storageKey = "savedNotificationTimes"
    
    func save() {
        if let data = try? JSONEncoder().encode(times) {
            UserDefaults.standard.set(data, forKey: storageKey)
            print("✅ 알림 목록 저장 완료")
        }
    }
    
    func load() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([NotificationTime].self, from: data) {
            times = decoded
            print("✅ 알림 목록 불러오기 완료")
        }
    }
}
