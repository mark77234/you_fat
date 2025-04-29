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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Food.self])
        let config = ModelConfiguration("RudyMark", schema: schema)
        return try! ModelContainer(for: schema, configurations: [config])
    }()
    
    var body: some Scene {
        WindowGroup {
            FirstInputView()
                .environmentObject(HomeViewModel())
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

