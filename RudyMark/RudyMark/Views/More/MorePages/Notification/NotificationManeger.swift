//
//  NotificationManeger.swift
//  RudyMark
//
//  Created by 트루디 on 5/25/25.
//

import UserNotifications

func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
        if let error = error {
            print("Notification permission error: \(error.localizedDescription)")
            completion(false)
        } else {
            print(granted ? "Permission granted" : "Permission denied")
            completion(granted)
        }
    }
}

class LocalNotificationManager {
    static let shared = LocalNotificationManager()
    
    // 권한 요청
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
                completion(false)
            } else {
                print(granted ? "✅ 알림 권한 허용됨" : "❌ 알림 권한 거부됨")
                completion(granted)
            }
        }
    }
    
    func scheduleNotification(for time: NotificationTime, type: NotificationType) {
        let content = UNMutableNotificationContent()
        
        content.title = "\(type.displayName) 알림"
        content.body = "\(time.formattedTime)에 알림이 예정되어 있습니다."
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = time.hour
        dateComponents.minute = time.minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(
            identifier: time.id.uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("🔴 알림 등록 실패: \(error.localizedDescription)")
            } else {
                print("✅ 알림 등록 완료: \(time.formattedTime)")
            }
        }
    }

    func removeNotification(id: UUID) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
        print("🗑 알림 삭제: \(id.uuidString)")
    }
}
