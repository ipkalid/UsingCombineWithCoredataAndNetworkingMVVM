//
//  PostApiApp.swift
//  PostApi
//
//  Created by kalid on 23/04/2022.
//

import SwiftUI

@main
struct PostApiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
