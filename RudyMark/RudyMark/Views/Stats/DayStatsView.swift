//
//  DayStatsView.swift
//  RudyMark
//
//  Created by 트루디 on 5/8/25.
//

import SwiftUI

struct DailyStatsView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack(spacing: 16) {
            // 제목 및 날짜 선택
            HStack {
                Text("일별 통계")
                    .font(.title3)
                    .bold()
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Button(action: {
                   // 누르면 1일 전 보여줌
                }) {
                    Image(systemName: "chevron.left")
                }
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .labelsHidden()
                Button(action: {}) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)

            // 차트 (간단한 예시, 실제 앱에서는 라이브러리 또는 Custom Shape 필요)
            LineChartView()
                .frame(height: 200)
                .padding(.horizontal)

            // 시간대별 수치
            HStack {
                StatColumn(title: "전날 저녁", calorie: 702, sugar: 92)
                StatColumn(title: "아침", calorie: 538, sugar: 104)
                StatColumn(title: "점심", calorie: 803, sugar: 123)
                StatColumn(title: "저녁", calorie: 756, sugar: 97)
            }
            .padding(.horizontal)

            // 하단 요약 카드
            HStack(spacing: 16) {
                SummaryCard(title: "평균 혈당", value: "108 mg/dL")
                SummaryCard(title: "물 섭취량", value: "5 컵")
            }
            HStack(spacing: 16) {
                SummaryCard(title: "최고 혈당", value: "123 mg/dL")
                SummaryCard(title: "최저 혈당", value: "97 mg/dL")
            }

            VStack(spacing: 4) {
                Text("총 섭취 칼로리")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("1250 / 2000kcal")
                    .font(.title2)
                    .bold()
            }
            .padding()
        }
    }
}

// MARK: - Custom Components

struct StatColumn: View {
    let title: String
    let calorie: Int
    let sugar: Int

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text("\(calorie)")
                .foregroundColor(.green)
            Text("\(sugar)")
                .foregroundColor(.purple)
        }
        .frame(maxWidth: .infinity)
    }
}

struct SummaryCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)
    }
}

// MARK: - Placeholder Line Chart

struct LineChartView: View {
    let calorieData = [702, 538, 803, 756]
    let sugarData = [92, 104, 123, 97]
    let labels = ["저녁", "아침", "점심", "저녁"]

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let halfHeight = height / 2
            let spacing = width / CGFloat(calorieData.count - 1)

            ZStack {
                // Y-axis labels - Calorie (top)
                VStack(alignment: .trailing, spacing: 0) {
                    ForEach([900, 600, 300, 0], id: \.self) { value in
                        Text("\(value)")
                            .font(.caption2)
                            .frame(height: halfHeight / 3, alignment: .top)
                            .offset(y: -4)
                        if value != 0 { Spacer(minLength: 0) }
                    }
                }
                .frame(height: halfHeight)
                .offset(x: -width / 2 + 24, y: -halfHeight / 2)

                // Y-axis labels - Sugar (bottom)
                VStack(alignment: .trailing, spacing: 0) {
                    Spacer(minLength: 0)
                    ForEach([150, 100, 50, 0], id: \.self) { value in
                        Text("\(value)")
                            .font(.caption2)
                            .frame(height: halfHeight / 3, alignment: .top)
                            .offset(y: -4)
                        if value != 0 { Spacer(minLength: 0) }
                    }
                }
                .frame(height: halfHeight)
                .offset(x: -width / 2 + 24, y: halfHeight / 2)

                // Grid and lines
                ZStack {
                    let gridLines = 3
                    ForEach(0..<gridLines) { i in
                        let yTop = halfHeight * CGFloat(i) / CGFloat(gridLines - 1)
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: yTop))
                            path.addLine(to: CGPoint(x: width, y: yTop))
                        }
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)

                        let yBottom = yTop + halfHeight
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: yBottom))
                            path.addLine(to: CGPoint(x: width, y: yBottom))
                        }
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    }

                    // Y-axis indicator (vertical line)
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLine(to: CGPoint(x: 0, y: height))
                    }
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)

                    // X-axis indicator (horizontal line in the middle)
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: halfHeight))
                        path.addLine(to: CGPoint(x: width, y: halfHeight))
                    }
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)

                    // Calorie line (top)
                    Path { path in
                        for (index, value) in calorieData.enumerated() {
                            let x = spacing * CGFloat(index)
                            let y = halfHeight * (1 - CGFloat(value) / 900)
                            if index == 0 {
                                path.move(to: CGPoint(x: x, y: y))
                            } else {
                                path.addLine(to: CGPoint(x: x, y: y))
                            }
                        }
                    }
                    .stroke(Color.green, lineWidth: 2)

                    // Sugar line (bottom)
                    Path { path in
                        for (index, value) in sugarData.enumerated() {
                            let x = spacing * CGFloat(index)
                            let y = halfHeight + halfHeight * (1 - CGFloat(value) / 150)
                            if index == 0 {
                                path.move(to: CGPoint(x: x, y: y))
                            } else {
                                path.addLine(to: CGPoint(x: x, y: y))
                            }
                        }
                    }
                    .stroke(Color.purple, lineWidth: 2)
                }

                // X-axis labels
                HStack(spacing: 0) {
                    ForEach(labels.indices, id: \.self) { idx in
                        Text(labels[idx])
                            .font(.caption2)
                            .frame(width: spacing, alignment: .center)
                    }
                }
                .frame(width: width)
                .offset(y: height / 2 - 10)
            }
        }
        .padding(.leading, 30)
    }
}

// MARK: - Preview

struct DailyStatsView_Previews: PreviewProvider {
    static var previews: some View {
        DailyStatsView()
    }
}

#Preview {
    DailyStatsView()
}
