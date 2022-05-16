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
    
    @NSManaged public var step: String
    @NSManaged public var order: Int16
}

extension Instruction: Identifiable {
    
}
