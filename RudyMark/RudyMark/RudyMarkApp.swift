//
//  RudyMarkApp.swift
//  RudyMark
//
//  Created by 트루디 on 3/24/25.
//

import SwiftUI
import SwiftData

@main
struct RudyMarkApp: App {
    @StateObject private var selectedFoodsViewModel = SelectedFoodsViewModel()
    @StateObject private var homeViewModel: HomeViewModel
    @StateObject private var userViewModel = UserViewModel()
    
    @State private var resetTimer: Timer?
    @AppStorage("lastResetDate") private var lastResetDate: String = ""
    
    var sharedModelContainer: ModelContainer = {
        do {
            return try ModelContainer(for: Food.self, BloodData.self)
        } catch {
            fatalError("❌ ModelContainer 로딩 실패: \(error)")
        }
    }()
    
    init() {
            let modelContext = sharedModelContainer.mainContext
            _homeViewModel = StateObject(wrappedValue: HomeViewModel(modelContext: modelContext))
        }
    
    var body: some Scene {
        WindowGroup {
            FirstInputView()
                .environmentObject(homeViewModel)
                .environmentObject(userViewModel)
                .environmentObject(selectedFoodsViewModel)
                .modelContainer(sharedModelContainer)
                .onAppear {
                    if !UserDefaults.standard.bool(forKey: "hasImportedCSV") {
                        let importer = CSVImporter(modelContext: sharedModelContainer.mainContext)
                        importer.importFoodsFromCSV()
                        UserDefaults.standard.set(true, forKey: "hasImportedCSV")
                        homeViewModel.loadPersistedFoods()
                    }
                    
                    setupDailyResetTimer()
                    checkForDailyReset()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                                    checkForDailyReset()
                                }

        }
    }
    private func checkForDailyReset() {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            let today = formatter.string(from: Date())
            
            if lastResetDate != today {
                resetAllData()
                lastResetDate = today
            }
        }
    
    private func setupDailyResetTimer() {
            resetTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                checkForDailyReset()
            }
        }
    private func resetAllData() {
           let context = sharedModelContainer.mainContext
           
           // 사용자 추가 음식 삭제
           let foodPredicate = #Predicate<Food> { $0.isUserAdded }
           let foodDescriptor = FetchDescriptor(predicate: foodPredicate)
           
           // 혈당 데이터 삭제
           let bloodPredicate = #Predicate<BloodData> { _ in true }
           let bloodDescriptor = FetchDescriptor(predicate: bloodPredicate)
           
           do {
               // 음식 데이터 삭제
               let userFoods = try context.fetch(foodDescriptor)
               userFoods.forEach { context.delete($0) }
               
               // 혈당 데이터 삭제
               let bloodData = try context.fetch(bloodDescriptor)
               bloodData.forEach { context.delete($0) }
               
               try context.save()
               
               // 뷰모델 상태 초기화
               homeViewModel.resetDailyData()
               
           } catch {
               print("데이터 리셋 실패: \(error)")
           }
       }
    
}
