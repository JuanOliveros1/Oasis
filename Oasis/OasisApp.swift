//
//  OasisApp.swift
//  Oasis
//
//  Created by Ezra Carrillo on 2/12/25.
//

import SwiftUI

@main
struct OasisApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MapView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
