//
//  DataController.swift
//  Cookbook (iOS)
//
//  Created by Jonathan Huber on 5/12/22.
//

import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Cookbook")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
