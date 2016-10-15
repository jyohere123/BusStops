//
//  BusStopsListDataController.swift
//  BusStops
//
//  Created by HM on 10/1/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import AlamofireImage

class BusStopsListDataController
{
    func  fetchBusStopsList(_ request: BusStopsList.Request, completion: @escaping (_ data: AnyObject?, _ error: NSError?) -> Void)
    {
        var url = kBaseURL;
        if let busStopId = request.busStopId
        {
            url =  url + busStopId
        }
        
        Alamofire.request(url, parameters: nil, encoding: URLEncoding.default)
            .validate()
            .responseJSON
            {
                (response) -> Void in
                
                guard response.result.isSuccess else
                {
                    print("Error while fetching BusStops: \(response.result.error)")
                    completion(nil, response.result.error! as NSError?)
                    return
                }
                
                completion(response.data as AnyObject?, nil)
                
            }
    }
    
}
