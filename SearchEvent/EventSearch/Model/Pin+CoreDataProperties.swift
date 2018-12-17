//
//  Pin+CoreDataProperties.swift
//  EventSearch
//
//  Created by Garrett Cone on 11/25/18.
//  Copyright © 2018 Garrett Cone. All rights reserved.
//

import Foundation
import CoreData

extension Pin {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pin> {
        
        return NSFetchRequest<Pin>(entityName: "Pin");
    }
    
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var isDownloaded: Bool
    @NSManaged public var events: NSSet?
}

extension Pin {
    
    @objc(addEventsObject:)
    @NSManaged public func addToEvents(_ value: Event)
    
    @objc(removeEventsObject:)
    @NSManaged public func removeFromEvents(_ value: Event)
    
    @objc(addEvents:)
    @NSManaged public func addToEvents(_ values: NSSet)
    
    @objc(removeEvents:)
    @NSManaged public func removeFromEvents(_ values: NSSet)
}
