//
//  BodyInformViewModel.swift
//  RudyMark
//
//  Created by 트루디 on 4/8/25.
//

import Foundation
import Observation

@Observable
class BodyInformViewModel {
    var name: String = ""
    var birth: Date = Date()
    var height: String = ""
    var weight: String = ""
    var isMale: Bool = true
    var medicationIntervalFromMeal: String = "0.0"
    
    var savedInform: BodyInform?
    
    func save() -> BodyInform? {
        guard let heightInt = Int(height),
              let weightInt = Int(weight),
              let interval = Double(medicationIntervalFromMeal) else { return nil }
        
        let bodyInform = BodyInform(
            name: name,
            birth: birth,
            height: heightInt,
            weight: weightInt,
            isMale: isMale
        )
        bodyInform.medicationIntervalFromMeal = interval
        savedInform = bodyInform
        return savedInform
    }
    
    // Delete
    func delete() {
        savedInform = nil
        name = ""
        birth = Date()
        height = ""
        weight = ""
        isMale = true
        medicationIntervalFromMeal = "0.0"
    }
}

// 저장된 화면을 보여주는 뷰
import SwiftUI

struct BodyInformSummaryView: View {
    let info: BodyInform
    
    var body: some View {
        Form {
            Section(header: Text("기본 정보")) {
                Text("이름: \(info.name)")
                Text("생년월일: \(formattedDate(info.birth))")
                Text("성별: \(info.isMale ? "남성" : "여성")")
                Text("키: \(info.height) cm")
                Text("몸무게: \(info.weight) kg")
            }
            
            Section(header: Text("복약 정보")) {
                Text("식후 복약 시간: \(info.medicationIntervalFromMeal, specifier: "%.1f") 시간 후")
            }
        }
        .navigationTitle("내 정보 요약")
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}


// 입력 및 저장하는 뷰
import SwiftUI

struct BodyInformView: View {
    @State private var viewModel = BodyInformViewModel()
    @State private var savedInform: BodyInform? = nil
    @State private var navigateToSummary = false
    
    var body: some View {
        NavigationStack{
            
            Form {
                Section(header: Text("기본 정보")) {
                    TextField("이름", text: $viewModel.name)
                    DatePicker("생년월일", selection: $viewModel.birth, displayedComponents: .date)
                    TextField("키 (cm)", text: $viewModel.height)
                        .keyboardType(.numberPad)
                    TextField("몸무게 (kg)", text: $viewModel.weight)
                        .keyboardType(.numberPad)
                    
                    Picker("성별", selection: $viewModel.isMale) {
                        Text("남성").tag(true)
                        Text("여성").tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("복약 정보")) {
                    TextField("식후 몇 시간 후 복약?", text: $viewModel.medicationIntervalFromMeal)
                        .keyboardType(.decimalPad)
                }
                
                Button("저장") {
                    if let saved = viewModel.save() {
                        savedInform = saved
                        navigateToSummary = true
                    } else {
                        print("저장 실패 - 유효하지 않은 값")
                    }
                }
            }
            .navigationTitle("신체 정보 입력")
            .navigationDestination(isPresented: $navigateToSummary) {
                if let info = savedInform {
                    BodyInformSummaryView(info: info)
                } else {
                    Text("정보를 불러올 수 없습니다")
                }
            }
        }
    }
}
#Preview{
    BodyInformView()
}
