//
//  BodyLabApp.swift
//  BodyLab
//
//  Created by Joseph DeWeese on 4/7/22.
//

import SwiftUI

@main
struct BodyLabApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            WorkoutsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
