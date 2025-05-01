//
//  UserViewModel.swift
//  RudyMark
//
//  Created by 트루디 on 4/8/25.
//

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    // 여기서 @Published로 변수 다 만들고 얘를 가져다 쓰도록 하여 MVVM에 가깝게 구현
    @Published var name: String = ""
    @Published var weight: String = ""
    @Published var height: String = ""
    @Published var isMale: Bool = true
    @Published var birth: Date = Date()
    @Published var diabetesType: DiabetesType = .type1
    @Published var medicationTiming: MedicationTiming = .immediately
    @Published var glucoseCheckTime: [GlucoseCheckTime] = []

    private let userDefaultsKey = "savedUser"
    
    // 변수 생성
    var user: User? {
        guard let w = Double(weight), let h = Double(height) else { return nil }
        return User(
            name: name,
            weight: w,
            height: h,
            isMale: isMale,
            birth: birth,
            diabetesType: diabetesType,
            medicationTiming: medicationTiming,
            glucoseCheckTime: glucoseCheckTime
        )
    }

    init() {
        loadUser()
    }

    // 저장 및 수정(둘 다 같은 맥락이기 때문에 분리할 필요 없음)
    func save() {
        guard let user = user,
              let encoded = try? JSONEncoder().encode(user) else { return }
        UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
    }

    // 저장된 정보 로드
    func loadUser() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let savedUser = try? JSONDecoder().decode(User.self, from: data) else { return }

        name = savedUser.name
        weight = String(savedUser.weight)
        height = String(savedUser.height)
        isMale = savedUser.isMale
        birth = savedUser.birth
        diabetesType = savedUser.diabetesType
        medicationTiming = savedUser.medicationTiming
        glucoseCheckTime = savedUser.glucoseCheckTime
    }

    // 초기화(필요하면 사용할 것)
    func clear() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
        name = ""
        weight = ""
        height = ""
        isMale = true
        birth = Date()
        diabetesType = .type1
        medicationTiming = .immediately
        glucoseCheckTime = []
    }
}
