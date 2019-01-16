//
//  EventsTableVC.swift
//  EventSearch
//
//  Created by Garrett Cone on 12/13/18.
//  Copyright © 2018 Garrett Cone. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EventsTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pin: Pin!
    
    // Outlets
    @IBOutlet var eventsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Events Nearby"
        
        try! fetchedResultsController.performFetch()
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController <Event> = {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let coreDataStack = delegate.coreDataStack
        
        let fetchedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        fetchedRequest.sortDescriptors = []
        let predicate = NSPredicate(format: "pin = %@", self.pin)
        fetchedRequest.predicate = predicate
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: coreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self as? NSFetchedResultsControllerDelegate
        
        eventsTableView.reloadData()
        
        return fetchedResultsController as! NSFetchedResultsController<Event>
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let items = fetchedResultsController.fetchedObjects?.count else {
            
            return 0
        }
        
        return items
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let coreDataStack = delegate.coreDataStack
        
        let cell = eventsTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        let event = fetchedResultsController.object(at: indexPath)
        
        if let eventData = event.eventData {
            
            performuUIUpdatesOnMain {
                    
                cell.textLabel?.text = "test"
                cell.imageView?.image = UIImage(data: eventData as Data)
                cell.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
            }
        } else {
            
            performuUIUpdatesOnMain {
                cell.activityIndicator.startAnimating()
            }
            
            YelpClient.sharedInstance().downloadImage(imagePath: event.eventURL!) { (imageData, error) in
                
                guard error == nil else {
                    
                    print("An error occurred while loading the photo from the URL: \(String(describing: error))")
                    return
                }
                
                event.eventData = imageData as NSData?
                coreDataStack.save()
                
                performuUIUpdatesOnMain {
                    cell.activityIndicator.hidesWhenStopped = true
                    cell.activityIndicator.stopAnimating()
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Pass data to the EventsDetailVC
        //let event = fetchedResultsController.object(at: indexPath)
        let controller = storyboard!.instantiateViewController(withIdentifier: "EventsDetailVC") as! EventsDetailVC
        
        navigationController!.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 85
    }
    
}
