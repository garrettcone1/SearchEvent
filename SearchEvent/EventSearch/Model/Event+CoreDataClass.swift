//
//  Event+CoreDataClass.swift
//  EventSearch
//
//  Created by Garrett Cone on 11/25/18.
//  Copyright © 2018 Garrett Cone. All rights reserved.
//

import Foundation
import CoreData

@objc(Event)
public class Event: NSManagedObject {
    
    convenience init(eventData: NSData?, eventURL: String?, context: NSManagedObjectContext) {
        
        if let ent = NSEntityDescription.entity(forEntityName: "Event", in: context) {
            
            self.init(entity: ent, insertInto: context)
            self.eventData = eventData
            self.eventURL = eventURL
        } else {
            
            fatalError("Unable to find entity name")
        }
    }
}
