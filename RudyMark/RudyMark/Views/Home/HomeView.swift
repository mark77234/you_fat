//
//  Untitled.swift
//  RudyMark
//
//  Created by 이병찬 on 3/25/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack{
            Color.greenBackground
                .ignoresSafeArea()
            ScrollView{
                VStack(
                    spacing: 30
                ){
                    ForEach(viewModel.cards, id: \.title){
                        card in CardView(card: card)
                    }
                }
                .padding(.top, 50)
                .padding(.bottom, 50)
                .background(
                    .grayBackground
                )
            }
        }
    }
}

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




#Preview {
    HomeView()
}
