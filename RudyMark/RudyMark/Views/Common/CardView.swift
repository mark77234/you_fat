//
//  Card.swift
//  RudyMark
//
//  Created by 이병찬 on 3/31/25.
//

import SwiftUI

struct CardView: View{
    let card: CardData
    
    var body: some View{
        VStack(alignment: .leading,spacing: 20){
            HStack{
                Text(card.title)
                    .font(.headline)
                    .foregroundColor(card.mainTextColor)
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                if let progress = card.progress{
                    Text("\(Int(progress)) / \(Int(card.max ?? 2000)) kcal")
                        .foregroundColor(Color.gray)
                }
            }
            if let description = card.description{
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(card.subTextColor)
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
            
            if let progress = card.progress{
                ProgressView(value: progress, total: card.max ?? 2000) // 일일 권장 칼로리
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.yellowBar))
                    .scaleEffect(x: 1.0, y: 3.0)
            }
            
            if let miniCards = card.miniCards {
                
                HStack{
                    ForEach(miniCards, id: \.title){ nutrient in
                        HStack{
                            MiniCardView(miniCard: nutrient,cardHeight: card.height)
                        }
                        .frame(maxWidth: .infinity,minHeight: card.miniCardsSize)
                        .background(card.miniCardsColor)
                        .cornerRadius(12)
                    }
                }
                
            }
            
            if let mealButtons = card.MealButtons {
                VStack {
                    ForEach(mealButtons, id: \.name) { button in
                        if let destination = button.destination {
                            NavigationLink(destination: destination) {
                                HStack {
                                    if let icon = button.icon {
                                        Image(systemName: icon)
                                    }
                                    
                                    Text(button.name)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(button.buttonColor)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                
                            }
                        } else {
                            Button(action: {
                                print("\(button.name) 버튼이 눌렸습니다!")
                            }) {
                                HStack {
                                    if let icon = button.icon {
                                        Image(systemName: icon)
                                    }
                                    Text(button.name)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.5)) // 비활성화 버튼 스타일
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                            .disabled(true) // destination이 없으면 버튼 비활성화
                        }
                    }
                }
            }
            
            
        }
        .padding()
        .frame(maxWidth: .infinity,minHeight: card.height)
        .background(card.backgroundColor)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct MiniCardView : View{
    let miniCard: MiniCard
    let cardHeight: CGFloat
    
    var body: some View{
        VStack(alignment: .leading){
            Text(miniCard.title)
                .font(.subheadline)
                .foregroundColor(.deepGray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                
            
            if let value = miniCard.value {
                Text("\(value)")
                    .padding(.leading, 10)
                    .foregroundColor(Color.black)
            }
            
            if let progress = miniCard.progress, let max = miniCard.max,let barColor = miniCard.barColor {
                Text("\(Int(progress)) / \(Int(max)) g")
                    .foregroundColor(Color.black)
                    .padding(.leading, 10)
                
                ProgressView(value: progress, total: max)
                    .progressViewStyle(LinearProgressViewStyle(tint: barColor))
                    .padding(.horizontal)
                    .scaleEffect(x: 1.0, y: 2.0)
            }
        }
        
    }
}
