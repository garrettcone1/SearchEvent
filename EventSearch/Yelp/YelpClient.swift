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
    
    func taskForGETMethod(_ latitude: Double, _ longitude: Double, _ completionHandlerForGET: @escaping (_ success: Bool, _ data: [[String: AnyObject]], _ error: NSError?) -> Void) {
        
//        var parametersWithAPIKey = parameters
//        parametersWithAPIKey[YelpParameterKeys.APIKey] = YelpParameterValues.APIKey as AnyObject?
        
        let methodParameters = [
        
            
        ]
        
        let request = NSMutableURLRequest(url: yelpURLFromParameters(parametersWithAPIKey, withPathExtension: method))
        print(request)
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
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
            
//            var parsedResult: [String: AnyObject]! = nil
//            do {
//
//                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject]
//            } catch {
//
//                print("Could not parse JSON data")
//            }
            
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
        }
        
        task.resume()
        return task
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
    
    private func yelpURLFromParameters(_ parameters: [String: AnyObject], withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.APIScheme
        components.host = Constants.APIHost
        components.path = Constants.APIPath + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
    
    class func sharedInstance() -> YelpClient {
        
        struct Singleton {
            
            static var sharedInstance = YelpClient()
        }
        return Singleton.sharedInstance
    }
}
