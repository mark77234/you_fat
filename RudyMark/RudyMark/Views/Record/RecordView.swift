//
//  RecordView.swift
//  RudyMark
//
//  Created by 이병찬 on 3/31/25.
//

import SwiftUI

struct RecordView: View {
    var body: some View {
        ZStack{
            Color.greenBackground
                .ignoresSafeArea()
            ScrollView{
                VStack(
                    spacing: 30
                ){
                    CardView2()
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

struct CardView2: View{
    
    var body: some View{
        VStack(alignment: .leading,spacing: 20){
            HStack{
                Text("기록뷰입니다")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity,minHeight: 110)
        .background(.gray)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}


#Preview {
    RecordView()
}
