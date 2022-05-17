//
//  Instruction.swift
//  Cookbook (iOS)
//
//  Created by Jonathan Huber on 5/15/22.
//

import Foundation
import CoreData

@objc(Instruction)
public class Instruction: NSManagedObject {
    
}

extension Instruction {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Instruction> {
        return NSFetchRequest<Instruction>(entityName: "Instruction")
    }
    
    @NSManaged public var step: String?
    @NSManaged public var order: Int16
    @NSManaged public var recipes: NSSet?
    
    public var recipesWrapper: [Recipe] {
        let set = recipes as? Set<Recipe> ?? []
        return set.sorted {
            $0.name ?? Constants.UNKOWN_NAME < $1.name ?? Constants.UNKOWN_NAME
        }
    }
}

extension Instruction {
    @objc(addRecipesObject:)
    @NSManaged public func addToRecipes(_ value: Recipe)
    
    @objc(removeRecipesObject:)
    @NSManaged public func removeFromRecipes(_ value: Recipe)
    
    @objc(addRecipes:)
    @NSManaged public func addToRecipes(_ values: NSSet)
    
    @objc(removeRecipes:)
    @NSManaged public func removeFromRecipes(_ values: NSSet)
}

extension Instruction: Identifiable {
    
}
