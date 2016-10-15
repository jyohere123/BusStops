//
//  BusStopsListInteractor.swift
//  BusStops
//
//  Created by HM on 10/1/16.
//  Copyright (c) 2016 MyLabSolutions. All rights reserved.
//

import UIKit

protocol BusStopsListInteractorInput
{
    func fetchBusStops(request: BusStopsList.Request)
}

protocol BusStopsListInteractorOutput
{
    func presentBusStops(response: BusStopsList.Response)
}

class BusStopsListInteractor: BusStopsListInteractorInput
{
    var output: BusStopsListInteractorOutput!
    var worker: BusStopsListWorker!
    
    // MARK: Business logic
    
    func fetchBusStops(request: BusStopsList.Request)
    {
        // Creating Worker to do the work
        if(worker == nil)
        {
            worker = BusStopsListWorker()
        }
        
        worker.fetchBusStops(request: request, completionHandler: { (busStops, error) in
            
            let response = BusStopsList.Response(busStops: busStops, error: error)
            
            // Passing the result to the Presenter
            self.output.presentBusStops(response: response)
        })
        
    }
}

