//
//  UserModel.swift
//  RudyMark
//
//  Created by 트루디 on 5/1/25.
//

import Foundation

struct User: Codable {
    var name: String // 이름
    var weight: Double // 몸무게
    var height: Double // 키
    var isMale: Bool // 성별
    var birth: Date // 생년월일
    var diabetesType: DiabetesType // 당뇨 유형
    var medicationTiming: MedicationTiming // 약 복용 시간
    var glucoseCheckTime: [GlucoseCheckTime] // 혈당 체크 시간
}


// 당뇨 유형
enum DiabetesType: String, Codable, CaseIterable {
    // CaseIterable: 스위프트에서 열거형(enum)의 각 케이스를 순회하거나 접근할 수 있도록 해주는 프로토콜
    case type1 = "제 1형"
    case type2 = "제 2형"
    case gestational = "임신성 당뇨"
    case other = "기타(유전, 노화 등)"
}

// 혈당 체크 시간
enum GlucoseCheckTime: String, Codable, CaseIterable, Identifiable {
    case morning6to9 = "6~9"
    case morning9to12 = "9~12"
    case afternoon12to15 = "12~15"
    case afternoon15to18 = "15~18"
    case evening18to21 = "18~21"
    case other = "그 외"

    var id: String { self.rawValue }
}

// 약 복용 시간
enum MedicationTiming: String, Codable, CaseIterable {
    case immediately = "즉시"
    case after30M = "30분 후"
    case after1H = "1시간 후"
    case after2H = "2시간 후"
}
