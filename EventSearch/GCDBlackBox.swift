//
//  GCDBlackBox.swift
//  EventSearch
//
//  Created by Garrett Cone on 11/13/18.
//  Copyright © 2018 Garrett Cone. All rights reserved.
//

import Foundation
import UIKit

func performuUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    
    DispatchQueue.main.async {
        updates()
    }
}
