//
//  Event+CoreDataProperties.swift
//  EventSearch
//
//  Created by Garrett Cone on 11/25/18.
//  Copyright © 2018 Garrett Cone. All rights reserved.
//

import Foundation
import CoreData

extension Event {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        
        return NSFetchRequest<Event>(entityName: "Event");
    }
    
    @NSManaged public var eventData: NSData?
    @NSManaged public var eventURL: String?
    @NSManaged public var pin: Pin?
    
    @NSManaged public var eventAbout: String?
    @NSManaged public var eventAddress: String?
    @NSManaged public var eventDate: String?
    @NSManaged public var eventTitle: String?
}
