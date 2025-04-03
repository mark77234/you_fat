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
                .padding(.vertical,50)
                .background(
                    .grayBackground
                )
            }
        }
    }
}


#Preview {
    HomeView()
}
