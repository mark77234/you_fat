//
//  MoreViewModel.swift
//  RudyMark
//
//  Created by 이병찬 on 4/3/25.
//
import SwiftUI

class MoreViewModel: ObservableObject {
    @Published var items: [MoreItem] = []
    
    init() {
        // 샘플 데이터 초기화 (아이콘은 SF Symbols 예시)
        items = [
            MoreItem(title: "선물하기",
                     iconName: "gift.fill",
                     destination: AnyView(Text("선물하기 페이지"))),
            MoreItem(title: "받은선물",
                     iconName: "gift.circle",
                     destination: AnyView(Text("받은선물 페이지"))),
            MoreItem(title: "톡딜",
                     iconName: "cart.fill",
                     destination: AnyView(Text("톡딜 페이지"))),
            MoreItem(title: "이모티콘",
                     iconName: "face.smiling",
                     destination: AnyView(Text("이모티콘 페이지"))),
            MoreItem(title: "라이브쇼핑",
                     iconName: "video.fill",
                     destination: AnyView(Text("라이브쇼핑 페이지"))),
            MoreItem(title: "브랜드패션",
                     iconName: "tshirt.fill",
                     destination: AnyView(Text("브랜드패션 페이지"))),
            MoreItem(title: "메이커스",
                     iconName: "hammer.fill",
                     destination: AnyView(Text("메이커스 페이지"))),
            MoreItem(title: "프렌즈",
                     iconName: "person.2.fill",
                     destination: AnyView(Text("프렌즈 페이지"))),
            MoreItem(title: "캘린더",
                     iconName: "calendar",
                     destination: AnyView(Text("캘린더 페이지"))),
            MoreItem(title: "톡서랍",
                     iconName: "tray.fill",
                     destination: AnyView(Text("톡서랍 페이지"))),
            MoreItem(title: "게임",
                     iconName: "gamecontroller.fill",
                     destination: AnyView(Text("게임 페이지"))),
            MoreItem(title: "예약하기",
                     iconName: "bookmark.fill",
                     destination: AnyView(Text("예약하기 페이지"))),
            MoreItem(title: "주문하기",
                     iconName: "bag.fill",
                     destination: AnyView(Text("주문하기 페이지"))),
            MoreItem(title: "간편구매",
                     iconName: "creditcard.fill",
                     destination: AnyView(Text("간편구매 페이지"))),
            MoreItem(title: "카카오맵",
                     iconName: "map.fill",
                     destination: AnyView(Text("카카오맵 페이지"))),
            MoreItem(title: "전체서비스",
                     iconName: "ellipsis.circle.fill",
                     destination: AnyView(Text("전체서비스 페이지")))
        ]
    }
}
