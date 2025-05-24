//
//  NotificationSetView.swift
//  RudyMark
//
//  Created by 트루디 on 5/25/25.
//
import SwiftUI

struct NotificationSetView: View {
    @EnvironmentObject private var viewModel: NotificationSetViewModel
    
    //    @EnvironmentObject private var viewModel: UserViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            List {
                Section {
                    Toggle(isOn: $viewModel.bloodSugarOn) {
                        Text("혈당 알림")
                    }
                    if viewModel.bloodSugarOn {
                        NavigationLink {
                            AlarmListView(type: .bloodSugar)
                        } label: {
                            HStack {
                                Text("혈당 측정 시간")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                    }
                }
                
                Section {
                    Toggle(isOn: $viewModel.mealOn) {
                        Text("식사 알림")
                    }
                    if viewModel.mealOn {
                        NavigationLink {
                            AlarmListView(type: .meal)
                        } label: {
                            HStack {
                                Text("식사 기록 알림")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        
                        Toggle(isOn: $viewModel.medicationOn) {
                            Text("복약 알림")
                        }
                        
                        if viewModel.medicationOn {
                            NavigationLink {
                                AlarmListView(type: .medication)
                            } label: {
                                HStack {
                                    Text("복약 시간")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
