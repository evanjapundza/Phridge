//
//  PhridgeApp.swift
//  Phridge
//
//  Created by Evan Japundza on 1/16/23.
//

import SwiftUI

@main
struct PhridgeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
