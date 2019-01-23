//
//  EventsDetailVC.swift
//  EventSearch
//
//  Created by Garrett Cone on 1/3/19.
//  Copyright © 2019 Garrett Cone. All rights reserved.
//

import Foundation
import UIKit

class EventsDetailVC: UIViewController {
    
    // Properties
    var event: Event?
    var isFavorite = false
    
    // Outlets
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var dateLogo: UIImageView!
    @IBOutlet weak var locationLogo: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.activityIndicator.alpha = 1.0
        //self.activityIndicator.startAnimating()
        populateDetailView()
    }
    
    func populateDetailView() {
        
        // Set up default UI and populate views with data
        self.dateLogo.image = UIImage(named: "date")
        self.locationLogo.image = UIImage(named: "location")
        
        if let eventImage = event?.eventData {
            
            performuUIUpdatesOnMain {
                self.posterImage.image = UIImage(data: eventImage as Data)
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
    }
}
