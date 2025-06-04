// FoodListView.swift
import SwiftUI

struct FoodListView: View {
    let foods: [Food]
    let onSelect: (Food) -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(foods) { food in
                    FoodCard(food: food, onTap: {
                        onSelect(food)
                    })
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
    }
}


struct SelectedFoodsView: View {
    let selectedFoods: [Food]
    let onRemove: (Food) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Divider().padding(.horizontal)
            HStack {
                Text("선택한 음식")
                    .font(.headline)
                Spacer()
                Text("\(selectedFoods.count)개")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(selectedFoods) { food in
                        SelectedFoodItem(food: food, onRemove: { onRemove(food) })
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
    }
}

struct SelectedFoodItem: View {
    let food: Food
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 2) {
                Text(food.name)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                Text("\(food.kcal, specifier: "%.0f")kcal")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color.purple.opacity(0.1))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 2, y: 1)
    }
}
