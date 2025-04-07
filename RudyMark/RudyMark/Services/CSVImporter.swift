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

    func importFoodsFromCSV() {
        guard let fileURL = Bundle.main.url(forResource: "foodData", withExtension: "csv") else {
            print("CSV 파일을 찾을 수 없습니다.")
            return
        }

        do {
            let content = try String(contentsOf: fileURL, encoding: .utf8)
            let rows = content.components(separatedBy: "\n")
            
            for row in rows.dropFirst() where !row.isEmpty { // 헤더 제외 + 빈 줄 제거
                let columns = row.components(separatedBy: ",")
                guard columns.count >= 2 else { continue }

                let name = columns[0].trimmingCharacters(in: .whitespacesAndNewlines)
                let calories = columns[1].trimmingCharacters(in: .whitespacesAndNewlines)

                let food = Food(name: name, calories: calories)
                modelContext.insert(food)
            }

            try modelContext.save()
            print("CSV 데이터를 저장했습니다 ✅")

        } catch {
            print("CSV 읽기 오류: \(error)")
        }
    }
}
