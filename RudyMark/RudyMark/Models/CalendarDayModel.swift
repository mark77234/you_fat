//
//  CalendarDayModel.swift
//  RudyMark
//
//  Created by 트루디 on 7/3/25.
//
import SwiftUI

struct CalendarDay: Identifiable {
    let id = UUID()
    let dayNumber: Int
    let isCurrentMonth: Bool // 현재 표시되는 월에 속하는지
    var isSelected: Bool = false // 사용자가 탭하여 선택한 날짜인지
    var isHighlighted: Bool = false // 미션 등으로 강조 표시되는 날짜인지 (스크린샷의 연보라색 원)
}
