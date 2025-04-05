//
//  MoreView.swift
//  RudyMark
//
//  Created by 이병찬 on 3/31/25.
//

import SwiftUI

// MARK: - MoreView
struct MoreView: View {
    @StateObject private var viewModel = MoreViewModel()
    
    // 4열 그리드
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.items) { item in
                        // 각 메뉴 아이템에 대한 NavigationLink
                        NavigationLink(destination: item.destination) {
                            VStack(spacing: 8) {
                                // 아이콘
                                Image(systemName: item.iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                
                                // 타이틀
                                Text(item.title)
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.lightPurple)
                            .cornerRadius(8)
                        }
                    }
                }
                .padding()
            }
            .toolbar {
                // principal 위치에 HStack을 사용해 "더보기" 타이틀과 gear 아이콘을 한 줄에 배치
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("더보기")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                        NavigationLink(destination: ProfileSettingView()) {
                            Image(systemName: "person.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                        }
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                }
            }
            .background(Color.grayBackground)
        }
    }
}



// MARK: - Preview
struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
