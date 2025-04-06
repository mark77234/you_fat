//
//  SugarStatsView.swift
//  RudyMark
//
//  Created by 트루디 on 3/31/25.
//

import SwiftUI
import Charts

struct SugarStatsView: View {
    @StateObject private var viewModel = SugarStatsViewModel()
    
    var body: some View {
        
        ZStack {
            Color.grayBackground.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .center) {
                    DateSelectionView(viewModel: viewModel)
                    
                    SugarChartView(data: [
                        (day: "06", value: 105),
                        (day: "09", value: 100),
                        (day: "12", value: 170),
                        (day: "15", value: 90),
                        (day: "18", value: 110),
                        (day: "21", value: 130),
                        (day: "24", value: 95)
                    ])
                    
                    VStack(spacing: 16) {
                        HStack {
                            Text("요약")
                                .font(.system(size: 15, weight: .medium))
                                .padding(.leading)
                            Spacer()
                        }
                        .padding(.top)
                        
                        HStack {
                            StatBox(title: "평균 단백질", value: "102 g", color: .lightYellow)
                            StatBox(title: "평균 지방", value: "63 g", color: .lightRed)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 16).fill(.white))
                        
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.white)
                    )
                    .padding(.horizontal)
                    
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
            Text("분석 결과")
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

import SwiftUI

struct DateSelectionView: View {
    @ObservedObject var viewModel: SugarStatsViewModel
    
    var body: some View {
        HStack {
            Button(action: { viewModel.changeDate(by: -7) }) {
                Image(systemName: "chevron.left")
            }
            
            Text(viewModel.formattedDate())
                .font(.system(size: 14, weight: .medium))
            
            Button(action: { viewModel.changeDate(by: 7) }) {
                Image(systemName: "chevron.right")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

import SwiftUI
import Charts

struct SugarChartView: View {
    let data: [(day: String, value: Int)]
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("혈당 수치")
                    .font(.system(size: 15, weight: .medium))
                    .padding(.leading)
                Spacer()
            }
            .padding(.top)
            
            Chart {
                ForEach(Array(data.enumerated()), id: \.offset) { index, entry in
                    BarMark(
                        x: .value("요일", entry.day),
                        y: .value("수치", entry.value)
                    )
                    .foregroundStyle(Color.bloodRed)
                }
            }
            .padding()
            .frame(width: 343, height: 332)
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .background(RoundedRectangle(cornerRadius: 16).fill(.white))
        .padding(.horizontal)
    }
}
