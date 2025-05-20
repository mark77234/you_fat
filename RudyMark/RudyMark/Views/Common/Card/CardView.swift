////
////  Card.swift
////  RudyMark
////
////  Created by 이병찬 on 3/31/25.
////
import SwiftUI

struct CardView: View{
    let card: CardData
    
    var body: some View{
        
        ZStack {
            VStack(alignment: .leading,spacing: 20){
                MainTitle(card: card)
                TodayKcalMiniCard(card: card)
                BloodCard(card: card)
                NutrientsMiniCardContainer(card: card)
                MealButtonsSection(card: card)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity,minHeight: card.height)
        .background(card.backgroundColor)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}




struct MealButtonsSection: View {
    let card: CardData
    
    var body: some View {
        if let mealButtons = card.MealButtons {
            VStack {
                ForEach(mealButtons, id: \.name) { button in
                    if let destination = button.destination {
                        NavigationLink(destination: destination) {
                            HStack {
                                if let icon = button.icon {
                                    icon
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:40,height:40)
                                }
                                Spacer()
                                VStack{
                                    if let buttonName = button.name{
                                        Text(buttonName)
                                            .font(.title3)
                                            .bold()
                                    }
                                    if let lastBlood = button.lastBlood{
                                        Text(lastBlood)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    if let lastDayKcal = button.lastDayKcal{
                                        Text(lastDayKcal)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                                Spacer()
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.deepPurple)
                                
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(button.buttonColor)
                            .foregroundColor(.black)
                            .cornerRadius(12)
                            
                        }
                    } else {
                        Button(action: {
                            print("버튼이 눌렸습니다!")
                        }) {
                            HStack {
                                if let icon = button.icon {
                                    icon
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:40,height:40)
                                }
                                Spacer()
                                VStack{
                                    if let buttonName = button.name{
                                        Text(buttonName)
                                            .font(.title3)
                                            .bold()
                                    }
                                    if let lastBlood = button.lastBlood{
                                        Text(lastBlood)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    if let lastDayKcal = button.lastDayKcal{
                                        Text(lastDayKcal)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                                Spacer()
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.deepPurple)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(button.buttonColor)
                            .foregroundColor(.black)
                            .cornerRadius(12)
                        }
                        .disabled(true) // destination이 없으면 버튼 비활성화
                    }
                }
            }
        }
    }
}




