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
            VStack(
                spacing: 30
            ){
                ForEach(viewModel.cards, id: \.title){
                    card in CardView(card: card)
                }
            }
            .background(
                .grayBackground
            )
        }
    }
}

struct CardView: View{
    let card: CardData
    
    var body: some View{
        VStack(
            alignment: .leading
        ){
            
            Text(
                card.title
            )
            .font(.headline)
            .foregroundColor(card.mainTextColor)
            .frame(maxWidth: .infinity,alignment: .leading)
            
            if let description = card.description{
                Text(description)
                .font(.subheadline)
                .foregroundColor(card.subTextColor)
                .frame(maxWidth: .infinity,alignment: .leading)
            }
            
            if let progress = card.progress{
                Text("\(Int(progress)) / \(Int(card.max ?? 2000)) kcal")
                                    .foregroundColor(Color.gray)
                                    
                ProgressView(value: card.progress, total: card.max ?? 2000) // 일일 권장 칼로리
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.yellowBar))
                    .scaleEffect(x: 1.0, y: 3.0)
            }
        }
        .padding()
        .frame(maxWidth: .infinity,minHeight: card.height)
        .background(card.backgroundColor)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

#Preview {
    HomeView()
}
