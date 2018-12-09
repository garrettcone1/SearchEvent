//
//  MapViewController.swift
//  EventSearch
//
//  Created by Garrett Cone on 12/6/18.
//  Copyright © 2018 Garrett Cone. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var coreDataController: CoreDataStack!
    
    lazy var fetchedResultsController: NSFetchedResultsController <NSFetchRequestResult> = {
        
        // Get the stack
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let stack = delegate.coreDataStack
        
        // Create a fetchRequest
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pin")
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "latitude", ascending: true),
            NSSortDescriptor(key: "longitude", ascending: true)
        ]
        
        // Create the FetchedResultsController
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performuUIUpdatesOnMain {
            self.loadMapDefaults()
        }
        
    }
    
    @IBAction func addPin(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizer.State.began {
            
            let location = sender.location(in: mapView)
            let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
            
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let coreDataStack = delegate.coreDataStack
            
            let pin = Pin(lat: coordinate.latitude, long: coordinate.longitude, isDownloaded: false, context: coreDataStack.context)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            
            self.mapView.addAnnotation(annotation)
            
            if !pin.isDownloaded {
                
                YelpClient.sharedInstance().getEventsForPin(pin: pin)
            }
            
            coreDataStack.save()
        }
    }
    
    
    fileprivate func loadMapDefaults() {
        
        let span = MKCoordinateSpan(latitudeDelta: UserDefaults.standard.double(forKey: "latDeltaKey"), longitudeDelta: UserDefaults.standard.double(forKey: "longDeltaKey"))
        
        let location = CLLocationCoordinate2D(latitude: UserDefaults.standard.double(forKey: "latitudeKey"), longitude: UserDefaults.standard.double(forKey: "longitudeKey"))
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.mapView.setRegion(region, animated: true)
    }
}
