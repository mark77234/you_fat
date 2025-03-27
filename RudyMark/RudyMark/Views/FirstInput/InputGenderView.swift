//
//  InputGenderView.swift
//  RudyMark
//
//  Created by 트루디 on 3/25/25.
//

import SwiftUI

struct InputGenderView: View {
    @EnvironmentObject var router: Router
    
    @State private var selectedGender: String? = nil
    @State private var progress = 10.0
    
    var body: some View {
        ZStack {
            Color.skyblue.ignoresSafeArea()
            
            VStack(spacing: 20) {
                ProgressbarView(progress: progress)
                    .onAppear {
                        progress = 25.0
                    }
                
                Text("성별")
                    .font(.title2).fontWeight(.bold)
                
                HStack(spacing: 20) {
                    SelectableButton(text: "남성", isSelected: selectedGender == "남성") {
                        selectedGender = "남성"
                    }
                    
                    SelectableButton(text: "여성", isSelected: selectedGender == "여성") {
                        selectedGender = "여성"
                    }
                }
                
                NextButton(isEnabled: selectedGender != nil, action: {
                    router.push(.InputPillTime)
                }, label: {
                    Text("다음")
                })
                
            }
            .padding(.horizontal, 24)
            .frame(height: 306/852 * UIScreen.main.bounds.height)
            .background(Color(.white).cornerRadius(20))
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    InputGenderView()
}
