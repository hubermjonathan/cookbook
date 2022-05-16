//
//  CookbookApp.swift
//  Shared
//
//  Created by Jonathan Huber on 5/12/22.
//

import SwiftUI

@main
struct CookbookApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
