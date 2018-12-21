//
//  YelpClient.swift
//  EventSearch
//
//  Created by Garrett Cone on 11/14/18.
//  Copyright © 2018 Garrett Cone. All rights reserved.
//

import Foundation
import UIKit

struct YelpEvent {
    let latitude: Double
    let longitude: Double
    let imageURL: String
    let timeStart: Double
}

typealias YelpEventsClosure = ([YelpEvent]?, Error?) -> ()

class YelpClient: NSObject {
    
    var session = URLSession.shared
    
    override init() {
        super.init()
    }
    
    func taskForGETMethod(latitude: Double, longitude: Double, completion: YelpEventsClosure?) {
        
        let methodParameters = [
            
            Constants.YelpParameterKeys.latitute: latitude,
            Constants.YelpParameterKeys.longitude: longitude,
            Constants.YelpParameterKeys.limit: Constants.YelpParameterValues.limit,
            Constants.YelpParameterKeys.radius: Constants.YelpParameterValues.radiusValue
            
        ] as [String: Any]
        
        let urlString = Constants.Yelp.APIScheme +
            Constants.Yelp.APIHost +
            Constants.Yelp.APIPath +
            Constants.Yelp.EventsEndpoint +
            escapedParameters(methodParameters as [String: AnyObject])
        
        let url = URL(string: urlString)!
        
        var request = NSMutableURLRequest(url: url)
        request.addValue("Bearer \(Constants.YelpParameterValues.APIKey)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: Error?) {
                completion?(nil, error)
            }
            
            guard (error == nil) else {
                
                print("There was an error with your request: \(String(describing: error))")
                sendError(error)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                
                print("Your request returned a status code other than 2xx!")
                sendError(nil)
                return
            }
            
            guard let data = data else {
                
                print("No data was returned by the request!")
                sendError(nil)
                return
            }
            
            var parsedResult: [String : AnyObject]? = nil
            
            do {
                parsedResult = try (JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject])
                
            } catch let error {
                
                sendError(error)
                print("Could not parse the data as JSON: '\(data)'")
            }
            
            guard let finalParsedResults = parsedResult else {
                
                print("Could not parse the data as JSON: '\(data)'")
                sendError(nil)
                return
            }
            
            if let eventDictionary = finalParsedResults[Constants.YelpResponseKeys.events] as? [[String: AnyObject]] {
                
                // Create an array of dictionaries containing the yelp events
                var events: [YelpEvent] = []
                
                eventDictionary.forEach {
                    let event = YelpEvent(
                                          latitude: $0[Constants.YelpResponseKeys.latitude] as? Double ?? 0.0,
                                          longitude: $0[Constants.YelpResponseKeys.longitude] as? Double ?? 0.0,
                                          imageURL: $0[Constants.YelpResponseKeys.image] as? String ?? "",
                                          timeStart: $0[Constants.YelpResponseKeys.date] as? Double ?? 0.0)
                    events.append(event)
                }
                completion?(events, nil)
            }
        }
        task.resume()
    }
    
    class func sharedInstance() -> YelpClient {
        
        struct Singleton {
            
            static var sharedInstance = YelpClient()
        }
        return Singleton.sharedInstance
    }
}

extension YelpClient {
    
    public func escapedParameters(_ parameters: [String: AnyObject]) -> String {
        
        if parameters.isEmpty {
            
            return ""
        } else {
            
            var keyValuePairs = [String]()
            
            for (key, value) in parameters {
                
                let stringValue = "\(value)"
                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                keyValuePairs.append(key + "=" + "\(escapedValue!)")
            }
            
            return "?\(keyValuePairs.joined(separator: "&"))"
        }
    }
}
