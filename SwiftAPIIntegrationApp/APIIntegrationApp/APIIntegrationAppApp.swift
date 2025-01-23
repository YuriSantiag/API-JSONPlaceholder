//
//  APIIntegrationAppApp.swift
//  APIIntegrationApp
//
//  Created by Yuri Santiago
//

import SwiftUI

@main
struct APIIntegrationAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
