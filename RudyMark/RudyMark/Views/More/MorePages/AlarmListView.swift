//
//  AlarmListView.swift
//  RudyMark
//
//  Created by 트루디 on 5/25/25.
//

import SwiftUI

struct AlarmListView: View {
    @EnvironmentObject private var viewModel: NotificationTimeListViewModel
    let type: NotificationType
    @State private var editingTime: NotificationTime? = nil

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.times(for: type)) { time in
                    HStack {
                        Text(time.formattedTime)
                        Spacer()
                        Toggle("", isOn: Binding(
                            get: { time.isOn },
                            set: { _ in viewModel.toggle(time.id) }
                        ))
                        .labelsHidden()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        editingTime = time
                    }
                }
            }

            Button {
                editingTime = NotificationTime(id: UUID(), hour: 9, minute: 0, isOn: true, type: type)
            } label: {
                Label("알림 추가", systemImage: "plus")
            }
            .padding()
        }
        .navigationTitle("시간 설정")
        .sheet(item: $editingTime) { time in
            AlarmEditView(
                time: time,
                onSave: { updated in
                    viewModel.update(updated)
                    LocalNotificationManager.shared.scheduleNotification(for: updated, type: type)
                },
                onDelete: {
                    viewModel.delete(time.id)
                    LocalNotificationManager.shared.removeNotification(id: time.id)
                }
            )
        }
    }
}
