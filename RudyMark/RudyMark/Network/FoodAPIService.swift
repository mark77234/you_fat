//
//  FoodAPIService.swift
//  RudyMark
//
//  Created by 이병찬 on 4/5/25.
//

import SwiftUI

// MARK: - 응답 구조

struct NutriResponse: Codable {
    let response: NutriBody
}

struct NutriBody: Codable {
    let body: NutriItems
}

struct NutriItems: Codable {
    let items: [FoodData]
}

// MARK: - API 서비스

class FoodAPIService {
    func fetchNutrition(foodName: String, completion: @escaping ([FoodData]) -> Void) {
        guard let encodedFoodName = foodName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                    print("음식 이름 인코딩 실패")
                    return
                }
        
        let urlString = "http://api.data.go.kr/openapi/tn_pubr_public_nutri_info_api?serviceKey=veH36vhp8GVgGk1iXCWkz0z%2BoAICisGrI3s%2FL9PowsJikONF7A7b2a%2FW1AvXxSr%2Fs3jCgNWwMZjiDK%2FE6SveCA%3D%3D&pageNo=1&numOfRows=100&type=json&foodNm=\(encodedFoodName)"
        
        guard let url = URL(string: urlString) else {
            print("잘못된 URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("에러: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("데이터 없음")
                return
            }

            do {
                let decoded = try JSONDecoder().decode(NutriResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decoded.response.body.items)
                }
            } catch {
                print("디코딩 실패: \(error)")
                if let raw = String(data: data, encoding: .utf8) {
                    print("응답 원본:\n\(raw)")
                }
            }
        }.resume()
    }
}

