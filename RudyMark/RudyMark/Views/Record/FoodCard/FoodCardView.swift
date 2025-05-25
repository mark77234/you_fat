// FoodCardView.swift
import SwiftUI

struct FoodCard: View {
    let food: Food
    let onTap: () -> Void
    
    private var sugarLevel: Color {
        switch food.sugar {
        case ..<5: return .green
        case 5..<10: return .orange
        default: return .red
        }
    }
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top) {
                    SugarIndicator(sugar: food.sugar)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(food.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text("\(food.kcal, specifier: "%.0f")kcal")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                
                NutritionBadges(carbs: food.carbs, protein: food.protein, fat: food.fat)
            }
            .padding()
            .cardBackground()
        }
    }
}

struct NutritionBadges: View {
    let carbs: Double
    let protein: Double
    let fat: Double
    
    var body: some View {
        HStack {
            NutritionBadge(value: carbs, unit: "g", label: "탄수", color: .purple)
            NutritionBadge(value: protein, unit: "g", label: "단백", color: .blue)
            NutritionBadge(value: fat, unit: "g", label: "지방", color: .orange)
        }
    }
}

struct SugarIndicator: View {
    let sugar: Double
    
    var sugarLevel: Color {
        switch sugar {
        case ..<5: return .green
        case 5..<10: return .orange
        default: return .red
        }
    }
    
    var body: some View {
        VStack(spacing: 4) {
            Text("당")
                .font(.caption2)
                .foregroundColor(.white)
            
            Text("\(sugar, specifier: "%.1f")g")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
        .padding(8)
        .frame(minWidth: 50)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(sugarLevel.gradient)
        )
    }
}

struct NutritionBadge: View {
    let value: Double
    let unit: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 2) {
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text("\(value, specifier: "%.1f")")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                
                Text(unit)
                    .font(.system(size: 10))
            }
            .foregroundColor(color)
            
            Text(label)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.secondary)
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.systemFill), lineWidth: 1)
        )
    }
}

// View Modifier
extension View {
    func cardBackground() -> some View {
        self.background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
        )
    }
}
