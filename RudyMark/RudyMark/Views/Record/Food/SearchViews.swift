//
//  SearchViews.swift
//  RudyMark
//
//  Created by 이병찬 on 5/20/25.
//
// SearchViews.swift
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                
                TextField("음식 이름 검색", text: $text)
                    .submitLabel(.search)
                    .onSubmit { onSearch() }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.05), radius: 2, y: 1)
            )
            
            if !text.isEmpty {
                Button("취소") {
                    text = ""
                }
                .transition(.opacity)
            }
        }
        .padding()
        .animation(.easeInOut, value: text)
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "fork.knife.circle")
                .font(.system(size: 60))
                .foregroundColor(.purple.opacity(0.3))
            
            Text("먹은 음식을 검색해보세요")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(maxHeight: .infinity)
    }
}

struct NoResultsView: View {
    let query: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.orange.opacity(0.3))
            
            Text("'\(query)'에 대한\n검색 결과가 없습니다")
                .font(.headline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxHeight: .infinity)
    }
}
