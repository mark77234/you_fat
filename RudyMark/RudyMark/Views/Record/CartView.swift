// CartView.swift

import SwiftUI
struct CartView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @EnvironmentObject private var cartViewModel: CartViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            if cartViewModel.selectedFoods.isEmpty {
                EmptyCartView()
            } else {
                List {
                    ForEach(cartViewModel.selectedFoods) { food in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(food.name)
                                    .font(.headline)
                                Text("\(food.kcal, specifier: "%.0f")kcal")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Button {
                                cartViewModel.remove(food)
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                }
                
                SaveButton {
                    for food in cartViewModel.selectedFoods {
                        homeViewModel.addFood(food)
                    }
                    cartViewModel.clear()
                }
                .padding()
            }
        }
        .navigationTitle("장바구니")
    }
}

struct EmptyCartView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cart.fill")
                .font(.system(size: 60))
                .foregroundStyle(.gray.opacity(0.3))
            
            Text("장바구니가 비어있습니다")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .frame(maxHeight: .infinity)
    }
}

struct SaveButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text("저장하기")
                    .font(.headline)
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(12)
        }
    }
}


