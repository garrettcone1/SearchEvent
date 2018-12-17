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

// This is a more common pattern in completion closures from API calls
// From the UI or whoever calls this, you can figure out if there was an error easily,
// and it is not a custom error that you made, which means you can take actions if they
// are Foundation errors or specific network erros.
// No need for a boolean success as you can check if the array is .some
typealias YelpEventsClosure = ([YelpEvent]?, Error?) -> ()

class YelpClient: NSObject {
    
    var session = URLSession.shared
    
    override init() {
        super.init()
    }
    
    func taskForGETMethod(latitude: Double, longitude: Double, completion: YelpEventsClosure?) {
        
        let methodParameters = [
            
            Constants.YelpParameterKeys.APIKey: Constants.YelpParameterValues.APIKey,
            Constants.YelpParameterKeys.latitute: latitude,
            Constants.YelpParameterKeys.longitude: longitude,
            Constants.YelpParameterKeys.radius: Constants.YelpParameterValues.radiusValue
            
            ] as [String: Any]
        
        let urlString = Constants.Yelp.APIScheme +
            Constants.Yelp.APIHost +
            Constants.Yelp.APIPath +
            escapedParameters(methodParameters as [String: AnyObject])
        
        let url = URL(string: urlString)!
        
        let request = NSMutableURLRequest(url: url)
        
        // Below request.addValue is a test to see if this is the correct request value for authentication
        //request.addValue("Authorization:", forHTTPHeaderField: "Bearer \(Constants.YelpParameterValues.APIKey)")
        
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
            
            // PARSE THE DATA HERE ***********
            //var parsedResult: [String: AnyObject]! = nil
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
            
<<<<<<< HEAD
            
            completionHandlerForGET(true, eventDictionary, nil)
||||||| merged common ancestors
            completionHandlerForGET(true, eventDictionary, nil)
=======
            if let eventDictionary = finalParsedResults[Constants.YelpResponseKeys.events] as? [[String: AnyObject]] {
                // here you have an array of dictionaries containing your yelp events
                
                var events: [YelpEvent] = []
                eventDictionary.forEach {
                    let event = YelpEvent(latitude: $0[Constants.YelpResponseKeys.latitude] as? Double ?? 0.0,
                                          longitude: $0[Constants.YelpResponseKeys.longitude] as? Double ?? 0.0,
                                          imageURL: $0[Constants.YelpResponseKeys.image] as? String ?? "",
                                          timeStart: $0[Constants.YelpResponseKeys.date] as? Double ?? 0.0)
                    events.append(event)
                }
                completion?(events, nil)
            }
            
>>>>>>> 6a2bd739d3ba61abbf2ff94ae8df4509ada23e64
        }
        
        task.resume()
    }
    
    private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedResult: [String: AnyObject]! = nil
        
        do {
            
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject]
        } catch {
            
            let userInfo = [NSLocalizedDescriptionKey: "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(parsedResult as AnyObject, nil)
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
