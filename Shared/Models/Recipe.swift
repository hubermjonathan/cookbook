//
//  Recipe.swift
//  Cookbook (iOS)
//
//  Created by Jonathan Huber on 5/15/22.
//

import Foundation
import CoreData

@objc(Recipe)
public class Recipe: NSManagedObject {
    
}

extension Recipe {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var image: Data?
    @NSManaged public var category: String?
    @NSManaged public var ingredients: NSSet?
    @NSManaged public var instructions: NSSet?
    
    public var ingredientsWrapper: [Ingredient] {
        let set = ingredients as? Set<Ingredient> ?? []
        return set.sorted {
            $0.name ?? Constants.UNKOWN_NAME < $1.name ?? Constants.UNKOWN_NAME
        }
    }
    
    public var instructionsWrapper: [Instruction] {
        let set = instructions as? Set<Instruction> ?? []
        return set.sorted {
            $0.order < $1.order
        }
    }
}

extension Recipe {
    @objc(addInstructionsObject:)
    @NSManaged public func addToInstructions(_ value: Instruction)
    
    @objc(removeInstructionsObject:)
    @NSManaged public func removeFromInstructions(_ value: Instruction)
    
    @objc(addInstructions:)
    @NSManaged public func addToInstructions(_ values: NSSet)
    
    @objc(removeInstructions:)
    @NSManaged public func removeFromInstructions(_ values: NSSet)
}

extension Recipe {
    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: Ingredient)
    
    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: Ingredient)
    
    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)
    
    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)
}

extension Recipe: Identifiable {
    
}
