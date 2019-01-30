//
//  CheckInternet.swift
//  EventSearch
//
//  Created by Garrett Cone on 1/29/19.
//  Copyright © 2019 Garrett Cone. All rights reserved.
//

import Foundation
import SystemConfiguration

public class CheckInternet {
    
    class func Connection() -> Bool {
        
        var noAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        noAddress.sin_len = UInt8(MemoryLayout.size(ofValue: noAddress))
        noAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultReachability = withUnsafePointer(to: &noAddress) {
            
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { noSockAddress in
                
                SCNetworkReachabilityCreateWithAddress(nil, noSockAddress)
            }
        }
        
        var reachabilityFlags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        
        if SCNetworkReachabilityGetFlags(defaultReachability!, &reachabilityFlags) == false {
            
            return false
        }
        
        let isReachable = (reachabilityFlags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (reachabilityFlags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        let returned = (isReachable && !needsConnection)
        
        return returned
    }
}
