//
//  Ingredient.swift
//  Cookbook (iOS)
//
//  Created by Jonathan Huber on 5/15/22.
//

import Foundation
import CoreData

@objc(Ingredient)
public class Ingredient: NSManagedObject {
    
}

extension Ingredient {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }
    
    @NSManaged public var category: String
    @NSManaged public var name: String
    @NSManaged public var amount: String
}

extension Ingredient: Identifiable {
    
}
