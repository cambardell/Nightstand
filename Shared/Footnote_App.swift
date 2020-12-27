//
//  Footnote_App.swift
//  Shared
//
//  Created by Cameron Bardell on 2020-12-27.
//

import SwiftUI

@main
struct Footnote_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
