//
//  SugarStatsView.swift
//  RudyMark
//
//  Created by 트루디 on 3/31/25.
//

import SwiftUI
import Charts

struct SugarStatsView: View {
    var body: some View {
        
        let weeklyCalories: [(day: String, calories: Int)] = [
            ("06", 130), ("09", 200), ("12", 100), ("15", 150), ("18", 200), ("21", 180), ("00", 80)
        ]
        
        let width_1 = 26/393 * UIScreen.main.bounds.width
        
        ZStack {
            Color.grayBackground.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .center) {
                    VStack(spacing: 16) {
                        HStack {
                            Text("혈당 수치")
                                .font(.system(size: 15, weight: .medium))
                                .padding(.leading)
                            Spacer()
                        }
                        .padding(.top)
                        
                        Chart {
                            ForEach(weeklyCalories, id: \.day) { data in
                                BarMark(
                                    x: .value("요일", data.day),
                                    y: .value("칼로리", data.calories),
                                    width: MarkDimension(floatLiteral: width_1)
                                )
                                .foregroundStyle(.red)
                            }
                        }
                        .padding()
                        .frame(width: 343/393 * UIScreen.main.bounds.width, height: 332/852 * UIScreen.main.bounds.height)
                        
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.white)
                    )
                    .padding(.horizontal)
                    
                    HStack {
                        StatBox(title: "평균 단백질", value: "102 g", color: .lightYellow)
                        StatBox(title: "평균 지방", value: "63 g", color: .lightRed)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.white)
                    )
                    
                    
                    AnalysisView(text: "이번 주 탄수화물 섭취량이 목표보다 약간 높습니다. 저녁 식사에서 탄수화물 섭취를 줄이고 단백질 섭취를 늘리는 것이 좋습니다.")
                }
                .padding()
            }
        }
    }
}
#Preview {
    SugarStatsView()
}

struct StatBox: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.grayFont)
            Text(value)
                .font(.system(size: 17, weight: .bold))
        }
        .padding()
        .frame(width: 147/393 * UIScreen.main.bounds.width, height: 80/852 * UIScreen.main.bounds.height)
        .background(color)
        .cornerRadius(10)
    }
}

struct AnalysisView: View {
    let text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            Text("요약")
                .foregroundStyle(.deepBlue)
                .font(.system(size: 15, weight: .medium))
            
            Text(text)
                .foregroundStyle(.deepBlue)
                .font(.system(size: 12, weight: .regular))
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.skyblue)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blueStroke, lineWidth: 1)
        )
        .padding()
    }
}
