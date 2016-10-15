//
//  BusStopsListWorker.swift
//  BusStops
//
//  Created by HM on 10/1/16.
//  Copyright (c) 2016 MyLabSolutions. All rights reserved.
//

import UIKit

class BusStopsListWorker
{
    // MARK: Business Logic
    var busStopsListDataController = BusStopsListDataController()
    
    func fetchBusStops(request: BusStopsList.Request, completionHandler: @escaping (_ busStops: [BusStop]?,  _ error: NSError?) -> ())
    {
        busStopsListDataController.fetchBusStopsList(request, completion:
            {
                (data, error) in
                
                if let error = error
                {
                    completionHandler(nil, error)
                }
                else
                {
                    let busStops = ResponseParser.parseBusStops(data: data)
                    completionHandler(busStops, nil)
                }
                
        });
    }
    
    
}
