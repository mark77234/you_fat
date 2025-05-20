//
//  RecordView.swift
//  RudyMark
//
//  Created by 이병찬 on 3/31/25.
//

import SwiftUI

struct RecordView: View {
    @StateObject var viewModel = RecordViewModel()
    var body: some View {
        ZStack{
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


#Preview {
    RecordView()
}
