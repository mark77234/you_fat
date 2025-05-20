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
                RecordCard(card: card)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity,minHeight: card.height)
        .background(card.backgroundColor)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}



