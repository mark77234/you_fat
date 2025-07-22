////
////  MissionListView.swift
////  RudyMark
////
////  Created by 트루디 on 7/3/25.
////
//
//import SwiftUI
//struct MissionListView: View {
//    let missions: [Mission] = [
//        Mission(name: "포도알 모으기", status: "25 / 30", iconName: "grape_icon", statusColor: Color.gray),
//        Mission(name: "단디하자!", status: "14일째", iconName: "grape_icon", statusColor: Color.gray),
//        Mission(name: "혈당 스파이크 10회 미만", status: "완수중", iconName: "grape_icon", statusColor: Color(red: 0.5, green: 0.3, blue: 0.7)) // "완수중"에 대한 보라색
//    ]
//    
//    var body: some View {
//        VStack(spacing: 15) {
//            ForEach(missions) { mission in
//                MissionCardView(mission: mission)
//            }
//        }
//    }
//}
