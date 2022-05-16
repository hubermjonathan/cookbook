//
//  Item.swift
//  Cookbook (iOS)
//
//  Created by Jonathan Huber on 5/15/22.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
}

extension Item {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }
    
    @NSManaged public var amount: String
    @NSManaged public var category: String
    @NSManaged public var name: String
}

extension Item: Identifiable {
    
}
