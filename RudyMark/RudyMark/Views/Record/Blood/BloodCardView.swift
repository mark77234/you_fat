//
//  BloodCardView.swift
//  RudyMark
//
//  Created by 이병찬 on 5/24/25.
//

import SwiftUI

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
