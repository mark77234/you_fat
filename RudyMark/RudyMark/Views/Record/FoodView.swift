import SwiftUI
import SwiftData

struct FoodView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var cartViewModel: CartViewModel // 변경: SelectedFoodsViewModel -> CartViewModel

    @State private var foods: [Food] = []
    @State private var searchQuery: String = ""
    @State private var foodToConfirm: Food?

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(text: $searchQuery, onSearch: fetchFoods)

                Group {
                    if searchQuery.isEmpty {
                        EmptyStateView()
                    } else if foods.isEmpty {
                        NoResultsView(query: searchQuery)
                    } else {
                        FoodListView(foods: foods, onSelect: { foodToConfirm = $0 })
                    }
                }
            }
            .navigationTitle("오늘의 식사")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        CartView()
                    } label: {
                        CartButton(count: cartViewModel.selectedFoods.count)
                    }
                }
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
        }
        .alert("음식을 추가할까요?", isPresented: Binding<Bool>(
            get: { foodToConfirm != nil },
            set: { if !$0 { foodToConfirm = nil } }
        )) {
            Button("추가") {
                if let food = foodToConfirm {
                    cartViewModel.add(food) // 변경: 장바구니에만 추가
                }
                foodToConfirm = nil
            }
            Button("취소", role: .cancel) {
                foodToConfirm = nil
            }
        } message: {
            if let food = foodToConfirm {
                Text("\(food.name) (\(food.kcal, specifier: "%.0f")kcal)을 장바구니에 담습니다.")
            }
        }
    }

    private func fetchFoods() {
        guard !searchQuery.isEmpty else { return }

        do {
            let descriptor = FetchDescriptor<Food>(
                predicate: #Predicate { $0.name.localizedStandardContains(searchQuery) }
            )
            let fetchedFoods = try context.fetch(descriptor)
            
            // 정확도 순 정렬 로직
            foods = fetchedFoods.sorted { a, b in
                let query = searchQuery.lowercased()
                let aName = a.name.lowercased()
                let bName = b.name.lowercased()
                
                // 1. 정확히 일치하는 경우
                let aExact = aName == query
                let bExact = bName == query
                if aExact != bExact {
                    return aExact
                }
                
                // 2. 검색어로 시작하는 경우
                let aStartsWith = aName.hasPrefix(query)
                let bStartsWith = bName.hasPrefix(query)
                if aStartsWith != bStartsWith {
                    return aStartsWith
                }
                
                // 3. 검색어가 포함된 위치 (빠른 위치가 우선)
                let aRange = aName.range(of: query)!
                let bRange = bName.range(of: query)!
                if aRange.lowerBound != bRange.lowerBound {
                    return aRange.lowerBound < bRange.lowerBound
                }
                
                // 4. 이름 길이가 짧은 순 (정확도가 높을 가능성)
                return a.name.count < b.name.count
            }
        } catch {
            print("🔴 검색 실패: \(error)")
            foods = []
        }
    }
}

struct CartButton: View {
    let count: Int

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "cart")
                .font(.title2)

            if count > 0 {
                Text("\(count)")
                    .font(.caption2)
                    .padding(5)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .offset(x: 8, y: -8)
            }
        }
    }
}
