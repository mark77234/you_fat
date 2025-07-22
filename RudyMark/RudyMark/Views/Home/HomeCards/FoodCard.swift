//
//  FoodCard.swift
//  RudyMark
//
//  Created by 이병찬 on 5/20/25.
//
import SwiftUI

struct TodayKcalMiniCard: View {
    let card: CardData
    
    var body: some View {
        if let progress = card.progress {
            VStack(alignment: .center) {
                HStack(alignment: .center, spacing: 10) {
                    (
                        Text("\(Int(progress))").bold().foregroundStyle(.black).font(.title)
                        + Text(" / \(Int(card.max ?? 2000)) kcal").foregroundStyle(.gray).font(.title3)
                    )
                }
                .frame(height: 80)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .background(Color(red: 0.94, green: 0.92, blue: 0.99))
                .cornerRadius(20)
                
            }
        }
    }
}



struct NutrientsMiniCardContainer: View {
    let card: CardData
    
    var body: some View {
        if let miniCards = card.miniCards {
            VStack{
                ForEach(miniCards, id: \.title){ nutrient in
                    HStack{
                        NutrientsMiniCard(miniCard: nutrient,cardHeight: card.height)
                    }
                    .frame(maxWidth: .infinity,minHeight: card.miniCardsSize)
                    .background(card.miniCardsColor)
                }
            }
        }
    }
}


struct NutrientsMiniCard : View{
    let miniCard: MiniCard
    let cardHeight: CGFloat
    
    var body: some View{
        VStack(alignment: .center){
            if let progress = miniCard.progress, let max = miniCard.max, let barColor = miniCard.barColor {
                HStack(alignment: .center,spacing:10) {
                    Text(miniCard.title)
                        .font(.subheadline)
                        .foregroundStyle(.deepGray)
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 140, height: 16)
                        RoundedRectangle(cornerRadius: 20)
                            .fill(barColor)
                            .frame(width: min(CGFloat(progress / max) * 140, 140), height: 16)
                    }
                    
                    (
                        Text("\(Int(progress))").bold().foregroundStyle(.black)
                        + Text(" / \(Int(max)) g").foregroundStyle(.black)
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}
