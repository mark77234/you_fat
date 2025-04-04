//
//  MoreView.swift
//  RudyMark
//
//  Created by 이병찬 on 3/31/25.
//

import SwiftUI


// MARK: - Main View
struct MoreView: View {
    @ObservedObject var viewModel = MoreViewModel()
    
    // 4열 그리드
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.items) { item in
                        // NavigationLink를 사용해 페이지 이동
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
                                    .foregroundColor(Color.white)
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
            .navigationTitle("더보기")
            // 배경색을 짙은 다크 스타일로
            .background(.grayBackground)
        }
    }
}

// MARK: - Preview
struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
