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
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventAddress: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    
    // Test for scrollview
    @IBOutlet weak var aboutScrollView: UIScrollView!
    
    // Logos
    @IBOutlet weak var dateLogo: UIImageView!
    @IBOutlet weak var locationLogo: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        populateDetailView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if CheckInternet.Connection() == false {
            
            alertMessage(message: "You are not connected to the internet.")
        }
    }
    
    public func alertMessage(message: String) {
        
        let alert = UIAlertController(title: "Uh oh!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func populateDetailView() {
        
        // Set up default UI and populate views with data
        self.dateLogo.image = UIImage(named: "date")
        self.locationLogo.image = UIImage(named: "location")
        
        if let eventImage = event?.eventData {
            
            performuUIUpdatesOnMain {
                self.posterImage.image = UIImage(data: eventImage as Data)
                self.eventTitle.text = self.event?.eventTitle
                self.eventDate.text = self.event?.eventDate
                self.eventAddress.text = self.event?.eventAddress
                self.eventDescription.text = self.event?.eventAbout
                
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
    }
}
