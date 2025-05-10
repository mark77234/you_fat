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
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var userViewModel = UserViewModel()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Food.self])
        let config = ModelConfiguration("RudyMark", schema: schema)
        return try! ModelContainer(for: schema, configurations: [config])
    }()
    
    var body: some Scene {
        WindowGroup {
            FirstInputView()
                .environmentObject(homeViewModel)
                .environmentObject(userViewModel)
                .environmentObject(selectedFoodsViewModel)
                .modelContainer(sharedModelContainer)
                .onAppear {
                    if !UserDefaults.standard.bool(forKey: "hasImportedCSV") {
                        let context = sharedModelContainer.mainContext
                        let importer = CSVImporter(modelContext: context)
                        importer.importFoodsFromCSV()
                        UserDefaults.standard.set(true, forKey: "hasImportedCSV")
                    }
                }

        }
    }
}

