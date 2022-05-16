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
    
    @NSManaged public var category: String?
    @NSManaged public var name: String?
    @NSManaged public var amount: String?
    @NSManaged public var recipes: NSSet?
    
    public var recipesWrapper: [Recipe] {
        let set = recipes as? Set<Recipe> ?? []
        return set.sorted {
            $0.name! < $1.name!
        }
    }
}

extension Ingredient {
    @objc(addRecipeObject:)
    @NSManaged public func addToRecipe(_ value: Recipe)
    
    @objc(removeRecipeObject:)
    @NSManaged public func removeFromRecipe(_ value: Recipe)
    
    @objc(addRecipe:)
    @NSManaged public func addToRecipe(_ values: NSSet)
    
    @objc(removeRecipe:)
    @NSManaged public func removeFromRecipe(_ values: NSSet)
}

extension Ingredient: Identifiable {
    
}
