//
//  RecordCard.swift
//  RudyMark
//
//  Created by 이병찬 on 5/20/25.
//
import SwiftUI

struct RecordCard: View {
    let card: CardData
    
    var body: some View {
        Group {
            if let mealButtons = card.MealButtons {
                VStack(spacing: 16) {
                    ForEach(mealButtons, id: \.name) { button in
                        RecordButton(button: button)
                    }
                }
            }
        }
    }
}

struct RecordButton: View {
    let button: RecordButton
    
    var body: some View {
        Group {
            if let destination = button.destination {
                NavigationLink(destination: destination) {
                    buttonContent
                }
            } else {
                Button(action: { print("버튼이 눌렸습니다!") }) {
                    buttonContent
                }
                .disabled(true)
            }
        }
        .background(button.buttonColor)
        .cornerRadius(12)
    }
    
    private var buttonContent: some View {
        HStack {
            iconView
            Spacer()
            textContent
            Spacer()
            plusIcon
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.black)
    }
    
    @ViewBuilder
    private var iconView: some View {
        if let icon = button.icon {
            icon
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
        }
    }
    
    private var textContent: some View {
        VStack {
            Text(button.name ?? "")
                .font(.title3)
                .bold()
            
            if let lastBlood = button.lastBlood {
                Text(lastBlood)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            if let lastDayKcal = button.lastDayKcal {
                Text(lastDayKcal)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
    
    private var plusIcon: some View {
        Image(systemName: "plus.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .foregroundColor(.deepPurple)
    }
}
