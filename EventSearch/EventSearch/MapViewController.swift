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
    @IBOutlet weak var deletePinButton: UIBarButtonItem!
    
    var coreDataController: CoreDataStack!
    
    var didTapEditMode = false
    
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
        
        self.mapView.delegate = self
        
        var objects: [Any]?
        
        do {
            
            try fetchedResultsController.performFetch()
            objects = (fetchedResultsController.sections?[0].objects)!
            
        } catch let error {
            
            print(error)
        }
        
        addAnnotationsToMapView(objects: objects)
    }
    
    @IBAction func addPin(_ sender: UILongPressGestureRecognizer) {
        
        print("Inside of addPin()")
        if sender.state == UILongPressGestureRecognizer.State.began {
            print("UIGestureRecognizer did begin.")
            
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
        } else {
            
            print("UIGestureRecognizer did not begin.")
        }
    }
    
    @IBAction func deletePin(_ sender: Any) {
        
        if deletePinButton.title == "Edit" {
            
            // Add delete label below to let user know they are in delete pins mode
            
            deletePinButton.title = "Done"
            didTapEditMode = true
        } else {
            
            deletePinButton.title = "Edit"
            didTapEditMode = false
        }
    }
    
    public func switchToTableVC(pin: Pin) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "TableVC") as! EventsTableVC
        controller.pin = pin
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    public func addAnnotationsToMapView(objects: [Any]?) {
        
        if let objects = objects {
            
            for object in objects {
                
                guard let pin = object as? Pin else {
                    
                    return
                }
                
                let lat = CLLocationDegrees(pin.latitude)
                let long = CLLocationDegrees(pin.longitude)
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    fileprivate func loadMapDefaults() {
        
        let span = MKCoordinateSpan(latitudeDelta: UserDefaults.standard.double(forKey: "latDeltaKey"), longitudeDelta: UserDefaults.standard.double(forKey: "longDeltaKey"))
        
        let location = CLLocationCoordinate2D(latitude: UserDefaults.standard.double(forKey: "latitudeKey"), longitude: UserDefaults.standard.double(forKey: "longitudeKey"))
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.mapView.setRegion(region, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        mapView.deselectAnnotation(view.annotation, animated: false)
        
        if didTapEditMode == false {
            
            let latitudePredicate = NSPredicate(format: "latitude == %lf", (view.annotation?.coordinate.latitude)!)
            let longitudePredicate = NSPredicate(format: "longitude == %lf", (view.annotation?.coordinate.longitude)!)
            let request = NSCompoundPredicate(type: .and, subpredicates: [latitudePredicate, longitudePredicate])
            
            fetchedResultsController.fetchRequest.predicate = request
            
            do {
                
                try fetchedResultsController.performFetch()
            } catch let error {
                
                print(error)
            }
            
            let pin = fetchedResultsController.sections?[0].objects?[0] as! Pin
            
            switchToTableVC(pin: pin)

        } else if didTapEditMode == true {
            
            let latitudePredicate = NSPredicate(format: "latitude == %lf", (view.annotation?.coordinate.latitude)!)
            let longitudePredicate = NSPredicate(format: "longitude == %lf", (view.annotation?.coordinate.longitude)!)
            let request = NSCompoundPredicate(type: .and, subpredicates: [latitudePredicate, longitudePredicate])
            
            fetchedResultsController.fetchRequest.predicate = request
            
            do {
                
                try fetchedResultsController.performFetch()
            } catch let error {
                
                print(error)
            }
            
            let pin = fetchedResultsController.sections?[0].objects?[0] as! Pin
            
            coreDataController.context.delete(pin)
            //coreDataController.context.delete(pin)
            try? coreDataController.context.save()
                    
            performuUIUpdatesOnMain {
                self.mapView.removeAnnotation(view.annotation!)
            }
        }
        
//        let latitudePredicate = NSPredicate(format: "latitude == %lf", (view.annotation?.coordinate.latitude)!)
//        let longitudePredicate = NSPredicate(format: "longitude == %lf", (view.annotation?.coordinate.longitude)!)
//        let request = NSCompoundPredicate(type: .and, subpredicates: [latitudePredicate, longitudePredicate])
//
//        fetchedResultsController.fetchRequest.predicate = request
//
//        do {
//
//            try fetchedResultsController.performFetch()
//        } catch let error {
//
//            print(error)
//        }
//
//        let pin = fetchedResultsController.sections?[0].objects?[0] as! Pin
//
//        switchToTableVC(pin: pin)
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        UserDefaults.standard.set(mapView.region.center.latitude, forKey: "latitudeKey")
        UserDefaults.standard.set(mapView.region.center.longitude, forKey: "longitudeKey")
        UserDefaults.standard.set(mapView.region.span.latitudeDelta, forKey: "latDeltaKey")
        UserDefaults.standard.set(mapView.region.span.longitudeDelta, forKey: "longDeltaKey")
        UserDefaults.standard.synchronize()
    }
}
