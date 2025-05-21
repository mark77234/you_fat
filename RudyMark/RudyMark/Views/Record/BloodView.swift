//
//  Untitled.swift
//  RudyMark
//
//  Created by 이병찬 on 3/31/25.
//

import SwiftUI
import Foundation

struct BloodView: View {
    @StateObject private var viewModel = BloodViewModel()
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                TimeCardView(currentTime: formattedCurrentTime())
                BloodSugarCardView(
                    bloodSugar: $viewModel.data.bloodSugar,
                    selectedMealState: Binding(
                        get: { viewModel.data.selectedMealState ?? "" },
                        set: { viewModel.data.selectedMealState = $0 }
                    )
                )
                WaterIntakeCardView(cups: $viewModel.data.waterIntake)
                
                Button(action: {
                    viewModel.saveMeasurement(homeViewModel: homeViewModel)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("저장하기")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(12)
                        .padding(.horizontal, 30)
                }
            }
            .padding(.horizontal)
           
        }
        .background(
            .grayBackground
        )
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        }
    }
}

struct BloodCardView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}


struct BloodRecordView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        List {
            ForEach(Array(homeViewModel.bloodSugarMeasurements.enumerated()), id: \.offset) { index, value in
                HStack {
                    Text("혈당 \(index + 1)")
                    Spacer()
                    Text("\(Int(value)) mg/dL")
                }
            }
            .onDelete { indexSet in
                homeViewModel.removeBloodSugarMeasurement(at: indexSet)
            }
        }
        .navigationTitle("혈당 기록")
        .toolbar {
            EditButton()
        }
    }
}

func formattedCurrentTime() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy년 M월 d일 a h:mm"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: Date())
}

struct TimeCardView: View {
    let currentTime: String
    
    var body: some View {
        Text(currentTime)
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .foregroundColor(.gray)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}

struct BloodSugarCardView: View {
    @Binding var bloodSugar: Double
    @Binding var selectedMealState: String
    let mealStates = ["취침 전", "식전", "식후", "공복"]
    let minSugar = 0.0
    let maxSugar = 200.0
    
    var body: some View {
        VStack(spacing: 16) {
            Text("혈당")
                .font(.headline)
            HStack {
                Picker("식사 상태", selection: $selectedMealState) {
                    ForEach(mealStates, id: \.self) { state in
                        Text(state)
                    }
                }
                .pickerStyle(.inline)
                .frame(height: 100)
                
                Text("\(Int(bloodSugar))")
                    .font(.title)
                    .bold()
                    .frame(minWidth: 100, alignment: .center)
                Text("mg/dL")
                    .font(.title3)
                    .foregroundColor(.gray)
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            Slider(value: $bloodSugar, in: minSugar...maxSugar)
                .accentColor(.purple)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .padding(.horizontal)
        
    }
}

struct WaterIntakeCardView: View {
    @Binding var cups: Int
    let maxCups: Int = 10

    var body: some View {
        VStack(spacing: 16) {
            Text("물 섭취량\n(1컵 - 200ml)")
                .font(.headline)
                .multilineTextAlignment(.center)

            HStack(spacing: 16) {
                Button(action: {
                    if cups > 0 {
                        cups = max(0, cups - 1)
                    }
                }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title)
                        .foregroundColor(.purple)
                }

                Text("\(cups)컵")
                    .font(.title2)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 24)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)

                Button(action: {
                    if cups < maxCups {
                        cups = min(maxCups, cups + 1)
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundColor(.purple)
                }
            }

            Text("총 \(cups * 200)ml")
                .font(.subheadline)
                .foregroundColor(.gray)

            let rows = [0..<5, 5..<10]
            ForEach(rows, id: \.self) { range in
                HStack(spacing: 16) {
                    ForEach(range, id: \.self) { index in
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.black, lineWidth: 1.5)
                                .frame(width: 35, height: 55)

                            if index < cups {
                                VStack {
                                    Spacer()
                                    Rectangle()
                                        .fill(Color.blue.opacity(0.6))
                                        .frame(height: 25)
                                        .cornerRadius(3)
                                }
                                .frame(width: 35, height: 55)
                            }

                            if index == cups && index < maxCups {
                                Text("+")
                                    .font(.title3)
                                    .foregroundColor(.gray)
                            }
                        }
                        .onTapGesture {
                            cups = index + 1
                        }
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
