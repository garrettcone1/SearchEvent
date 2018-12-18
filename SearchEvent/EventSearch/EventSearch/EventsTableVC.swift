//
//  EventsTableVC.swift
//  EventSearch
//
//  Created by Garrett Cone on 12/13/18.
//  Copyright © 2018 Garrett Cone. All rights reserved.
//

import Foundation
import UIKit

class EventsTableVC: UITableViewController {
    
    @IBOutlet var eventsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parent!.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    }
    
    @objc func done() {
        
        dismiss(animated: true, completion: nil)
    }
}
