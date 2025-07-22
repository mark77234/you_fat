//
//  MonthYearSelectorView.swift
//  RudyMark
//
//  Created by 트루디 on 7/3/25.
//
import SwiftUI

struct MonthYearSelectorView: View {
    @ObservedObject var viewModel: CalendarViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 🔻 상단 월/연도 표시 버튼 (토글용)
            Button(action: {
                viewModel.syncWithSelectedDate() // 현재 날짜를 피커에 반영
                withAnimation(.smooth(duration: 0.5)) {
                    viewModel.showPicker.toggle()
                }
            }) {
                HStack {
                    Spacer()
                    Text(viewModel.formattedDate) // 예: "2025년 4월"
                        .foregroundStyle(.black)
                        .font(.setPretendard(weight: .semiBold, size: 20))
                    Image(systemName: viewModel.showPicker ? "chevron.up" : "chevron.down")
                        .font(.setPretendard(weight: .semiBold, size: 20))
                    Spacer()
                }
                .padding()
            }

            // 🔻 드롭다운 피커
            if viewModel.showPicker {
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        Picker("Year", selection: $viewModel.currentYear) {
                            ForEach(viewModel.years, id: \.self) { year in
                                Text("\(viewModel.yearFormatter.string(from: NSNumber(value: year)) ?? "\(year)")년")
                                    .tag(year)
                            }
                        }
                        .pickerStyle(.wheel)
                        .labelsHidden()
                        .frame(width: 150)

                        Picker("Month", selection: $viewModel.currentMonth) {
                            ForEach(viewModel.months, id: \.self) { month in
                                Text("\(month)월").tag(month)
                            }
                        }
                        .pickerStyle(.wheel)
                        .labelsHidden()
                        .frame(width: 100)
                        Spacer()
                    }
                    .frame(height: 200)

                    Button(action: {
                        viewModel.updateDate()
                        withAnimation(.smooth(duration: 0.5)) {
                            viewModel.showPicker.toggle()
                        }
                    }) {
                        Text("완료")
                            .font(.system(size: 16, weight: .semibold))
                            .padding()
                            .foregroundStyle(.purple)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
