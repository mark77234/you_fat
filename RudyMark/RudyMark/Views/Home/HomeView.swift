//
//  Untitled.swift
//  RudyMark
//
//  Created by 이병찬 on 3/25/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack{
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


#Preview {
    HomeView()
}
