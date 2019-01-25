//
//  YelpConvenience.swift
//  EventSearch
//
//  Created by Garrett Cone on 11/14/18.
//  Copyright © 2018 Garrett Cone. All rights reserved.
//

import Foundation
import UIKit

extension YelpClient {
    
    public func getEventsForPin(pin: Pin) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let coreDataStack = appDelegate.coreDataStack
        
        performuUIUpdatesOnMain {
            YelpClient.sharedInstance().taskForGETMethod(latitude: pin.latitude, longitude: pin.longitude) { (events, error) in
                
                if let events = events {
                    
                    for event in events {
                        
                        let eventURL = event.imageURL
                        let eventAbout = event.eventAbout
                        let eventAddress = event.eventAddress
                        let eventDate = event.eventDate
                        let eventTitle = event.eventTitle
                        
                        //let event = Event(eventData: nil, eventURL: eventURL, context: coreDataStack.context)
                        let event = Event(eventData: nil, eventURL: eventURL, eventAbout: eventAbout, eventAddress: eventAddress, eventDate: eventDate, eventTitle: eventTitle, context: coreDataStack.context)
                        
                        print(event)
                        pin.addToEvents(event)
                        
                        coreDataStack.save()
                    }
                }
                
                pin.isDownloaded = true
            }
        }
    }
}
