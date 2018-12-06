//
//  YelpClient.swift
//  EventSearch
//
//  Created by Garrett Cone on 11/14/18.
//  Copyright © 2018 Garrett Cone. All rights reserved.
//

import Foundation
import UIKit

class YelpClient: NSObject {
    
    var session = URLSession.shared
    
    var requestToken: String? = nil
    
    override init() {
        super.init()
    }
    
    func taskForGETMethod(latitude: Double, longitude: Double, _ completionHandlerForGET: @escaping (_ success: Bool, _ data: [[String: AnyObject]]?, _ error: NSError?) -> Void) {
        
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
        request.addValue("Authorization:", forHTTPHeaderField: "Bearer \(Constants.YelpParameterValues.APIKey)")
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForGET(false, nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                
                sendError("There was an error with your request: \(String(describing: error))")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else {
                
                sendError("No data was returned by the request!")
                return
            }
            
            // PARSE THE DATA HERE ***********
            var parsedResult: [String: AnyObject]! = nil
            
            do {
                
                parsedResult = try (JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject])!
                print(parsedResult)
            } catch {
                
                print("Could not parse the data as JSON: '\(data)'")
            }
            //self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
            completionHandlerForGET(true, nil, nil)
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
