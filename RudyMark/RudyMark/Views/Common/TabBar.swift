//
//  TabBar.swift
//  RudyMark
//
//  Created by 이병찬 on 3/28/25.
//

import SwiftUI


struct TabBar: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("홈", systemImage: "house.fill")
                }
            
            RecordView()
                .tabItem {
                    Label("기록", systemImage: "clock.fill")
                }
            
            StatsView()
                .tabItem {
                    Label("통계", systemImage: "chart.bar.fill")
                }
            
            MoreView()
                .tabItem {
                    Label("더보기", systemImage: "ellipsis.circle.fill")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TabBar()
}
