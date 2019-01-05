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
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parent!.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController <Event> = {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let coreDataStack = delegate.coreDataStack
        
        let fetchedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        fetchedRequest.sortDescriptors = []
        let predicate = NSPredicate(format: "pin = %@", self.pin)
        fetchedRequest.predicate = predicate
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: coreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Double check this
        fetchedResultsController.delegate = self as? NSFetchedResultsControllerDelegate
        
        eventsTableView.reloadData()
        
        return fetchedResultsController as! NSFetchedResultsController<Event>
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sections = fetchedResultsController.sections?[section] else {
            
            return 0
        }
        
        return sections.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let coreDataStack = delegate.coreDataStack
        
        let cell = eventsTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        
        let event = fetchedResultsController.object(at: indexPath)
        
        if let eventData = event.eventData {
            
            
        }
        
        return cell
    }
    
    @objc func done() {
        
        dismiss(animated: true, completion: nil)
    }
}
