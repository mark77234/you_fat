import SwiftUI
import SwiftData

struct FoodView: View {
    @Environment(\.modelContext) private var context
    @State private var foods: [Food] = []
    @State private var searchQuery: String = ""
    @State private var isSearching = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 검색 바
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.white)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.secondary)
                                .padding(.leading, 12)
                            
                            TextField("검색할 음식을 입력하세요", text: $searchQuery)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)
                                .padding(.vertical, 12)
                        }
                    }
                    .frame(height: 52)
                    
                    Button(action: {fetchFoods()}) {
                        Image(systemName: "arrow.right")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.deepPurple)
                            .frame(width: 52, height: 52)
                            .background(.purpleBackground)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(.white)
                
                // 컨텐츠 영역
                if foods.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "fork.knife.circle")
                            .font(.system(size: 60))
                            .foregroundColor(.secondary.opacity(0.3))
                        
                        Text("검색어를 입력해 영양정보를 확인하세요")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .font(.system(size: 16, weight: .medium))
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(foods) { food in
                                FoodCardView(food: food)
                                    .padding(.horizontal, 20)
                            }
                        }
                        .padding(.vertical, 16)
                    }
                    .background(.white)
                }
            }
            .navigationTitle("영양 정보 검색")
            .navigationBarTitleDisplayMode(.inline)
            .background(.white)
        }
    }
    
    private func fetchFoods() {
        guard !searchQuery.isEmpty else {
            foods = []
            return
        }
        
        do {
            let descriptor = FetchDescriptor<Food>(
                predicate: #Predicate { $0.name.localizedStandardContains(searchQuery) }
            )
            foods = try context.fetch(descriptor)
        } catch {
            print("검색 오류: \(error)")
            foods = []
        }
    }
}

// MARK: - 음식 카드 뷰
struct FoodCardView: View {
    let food: Food
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                // 음식 이름 & 기본 정보
                VStack(alignment: .leading, spacing: 8) {
                    Text(food.name)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text("\(food.kcal, specifier: "%.0f") kcal")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // 당류 강조 표시
                VStack(alignment: .trailing) {
                    Text("당류")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.red)
                    
                    Text("\(food.sugar, specifier: "%.1f")g")
                        .font(.system(size: 20, weight: .heavy))
                        .foregroundColor(.red)
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.red.opacity(0.1))
                )
            }
            .padding(.bottom, 16)
            
            // 영양소 바
            HStack(spacing: 12) {
                NutrientBadge(title: "탄수화물", value: food.carbs, color: .purple)
                NutrientBadge(title: "단백질", value: food.protein, color: .blue)
                NutrientBadge(title: "지방", value: food.fat, color: .orange)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
    }
}

// MARK: - 영양소 뱃지
struct NutrientBadge: View {
    let title: String
    let value: Double
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(color)
            
            Text("\(value, specifier: "%.1f")g")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(color)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(color.opacity(0.1))
        )
    }
}

// MARK: - 프리뷰
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Food.self, configurations: config)
    
    let sampleFood = Food(
        name: "그릭",
        kcal: 150,
        carbs: 12,
        protein: 20,
        fat: 5,
        sugar: 8
    )
    container.mainContext.insert(sampleFood)
    
    return FoodView()
        .modelContainer(container)
}
