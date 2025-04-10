//
//  CSVImporter.swift
//  RudyMark
//
//  Created by 이병찬 on 4/7/25.
//

//
//  CSVImporter.swift
//  RudyMark
//
//  Created by 이병찬 on 4/7/25.
//

import Foundation
import SwiftData

class CSVImporter {
    let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func importFoodsFromCSV(searchQuery: String? = nil) {
        guard let fileURL = Bundle.main.url(forResource: "foodData", withExtension: "csv") else {
            print("CSV 파일을 찾을 수 없습니다.")
            return
        }

        do {
            let content = try String(contentsOf: fileURL, encoding: .utf8)
            let rows = content.components(separatedBy: .newlines).filter { !$0.isEmpty }

            guard let headerLine = rows.first else {
                print("CSV 헤더가 없습니다.")
                return
            }

            // 쉼표로 구분된 CSV 파일에 맞게 분리
            let columns = headerLine.components(separatedBy: ",")
            
            // 필요한 열 인덱스 찾기
            guard let nameIndex = columns.firstIndex(of: "식품명"),
                  let kcalIndex = columns.firstIndex(of: "에너지(kcal)"),
                  let carbsIndex = columns.firstIndex(of: "탄수화물(g)"),
                  let proteinIndex = columns.firstIndex(of: "단백질(g)"),
                  let fatIndex = columns.firstIndex(of: "지방(g)"),
                  let sugarIndex = columns.firstIndex(of: "당류(g)")
            else {
                print("필요한 열이 없습니다.")
                return
            }

            for row in rows.dropFirst() {
                let values = row.components(separatedBy: ",")
                guard values.count > max(nameIndex, kcalIndex, carbsIndex, proteinIndex, fatIndex, sugarIndex) else { continue }

                let name = values[nameIndex].trimmingCharacters(in: .whitespacesAndNewlines)
                
                // 검색어가 있다면 음식명에 검색어가 포함되어 있는지 확인
                if let query = searchQuery, !name.lowercased().contains(query.lowercased()) {
                    continue
                }
                
                let kcal = Double(values[kcalIndex]) ?? 0
                let carbs = Double(values[carbsIndex]) ?? 0
                let protein = Double(values[proteinIndex]) ?? 0
                let fat = Double(values[fatIndex]) ?? 0
                let sugar = Double(values[sugarIndex]) ?? 0

                let food = Food(name: name, kcal: kcal, carbs: carbs, protein: protein, fat: fat, sugar: sugar)
                modelContext.insert(food)
            }

            try modelContext.save()
            print("CSV 데이터를 저장했습니다 ✅")

        } catch {
            print("CSV 읽기 오류: \(error)")
        }
    }
}
