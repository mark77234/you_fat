//
//  AlarmEditView.swift
//  RudyMark
//
//  Created by 트루디 on 5/25/25.
//

import SwiftUI

struct AlarmEditView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var time: NotificationTime
    var onSave: (NotificationTime) -> Void
    var onDelete: () -> Void
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                DatePicker("", selection: Binding(
                    get: {
                        Calendar.current.date(from: DateComponents(hour: time.hour, minute: time.minute)) ?? Date()
                    },
                    set: { date in
                        let comps = Calendar.current.dateComponents([.hour, .minute], from: date)
                        time.hour = comps.hour ?? 0
                        time.minute = comps.minute ?? 0
                    }
                ), displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                
                Button("저장") {
                    onSave(time)
                    dismiss()
                }
                
                Button("알림 삭제하기", role: .destructive) {
                    onDelete()
                    dismiss()
                }
                
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("저장") {
                    onSave(time)
                    dismiss()
                }
            }
        }
    }
}
