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
                BloodCardView(
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

