import SwiftUI
import SwiftData

struct FoodView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var cartViewModel: CartViewModel

    @State private var foods: [Food] = []
    @State private var searchQuery: String = ""
    @State private var selectedFood: Food?

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
                        FoodListView(foods: foods, onSelect: { selectedFood = $0 })
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
            .navigationDestination(item: $selectedFood) { food in
                FoodDetailView(food: food)
                    .environmentObject(cartViewModel)
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

            foods = fetchedFoods.sorted { a, b in
                let query = searchQuery.lowercased()
                let aName = a.name.lowercased()
                let bName = b.name.lowercased()

                let aExact = aName == query
                let bExact = bName == query
                if aExact != bExact {
                    return aExact
                }

                let aStartsWith = aName.hasPrefix(query)
                let bStartsWith = bName.hasPrefix(query)
                if aStartsWith != bStartsWith {
                    return aStartsWith
                }

                let aRange = aName.range(of: query)!
                let bRange = bName.range(of: query)!
                if aRange.lowerBound != bRange.lowerBound {
                    return aRange.lowerBound < bRange.lowerBound
                }

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
