//
//  StatsView.swift
//  RudyMark
//
//  Created by 이병찬 on 3/31/25.
//

import SwiftUI

struct StatsView: View {
    @State private var selectedTab: Int = 0 // 0: 식사, 1: 혈당

    var body: some View {
        NavigationView {
            VStack {
                Picker("통계 선택", selection: $selectedTab) {
                    Text("식사").tag(0)
                    Text("혈당").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if selectedTab == 0 {
                    MealStatsView()
                } else {
                    SugarStatsView()
                }
            }
            .navigationTitle("통계")
        }
    }
}

#Preview {
    StatsView()
}
