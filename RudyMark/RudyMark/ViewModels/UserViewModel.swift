//
//  UserViewModel.swift
//  RudyMark
//
//  Created by 트루디 on 4/8/25.
//

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var weight: String = ""
    @Published var height: String = ""
    @Published var isMale: Bool = true
    @Published var birth: Date = Date()
    @Published var diabetesType: DiabetesType = .type1
    @Published var medicationTiming: MedicationTiming = .immediately
    @Published var glucoseCheckTime: [GlucoseCheckTime] = []

    private let userDefaultsKey = "savedUser"

    // MARK: - 전체 유저 모델 생성
    private func getUpdatedUser() -> User? {
        let w = Double(weight) ?? 0
        let h = Double(height) ?? 0
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

    // MARK: - 저장
    func save() {
        guard let user = getUpdatedUser(),
              let encoded = try? JSONEncoder().encode(user) else {
            print("❌ 저장 실패")
            return
        }
        UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
    }

    func saveName(_ newName: String) {
        name = newName
        save()
    }

    func saveWeight(_ newWeight: String) {
        weight = newWeight
        save()
    }

    func saveHeight(_ newHeight: String) {
        height = newHeight
        save()
    }

    func saveGender(_ isMale: Bool) {
        self.isMale = isMale
        save()
    }

    func saveBirth(_ birth: Date) {
        self.birth = birth
        save()
    }

    func saveDiabetesType(_ type: DiabetesType) {
        self.diabetesType = type
        save()
    }

    func saveMedicationTiming(_ timing: MedicationTiming) {
        self.medicationTiming = timing
        save()
    }

    func saveGlucoseCheckTime(_ times: [GlucoseCheckTime]) {
        self.glucoseCheckTime = times
        save()
    }

    // MARK: - 로드
    init() {
        loadUser()
    }

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

    // MARK: - 초기화
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
