//
//  BusStopsListModels.swift
//  BusStops
//
//  Created by HM on 10/1/16.
//  Copyright (c) 2016 MyLabSolutions. All rights reserved.
//

import UIKit

struct BusStopsList
{
    struct Request
    {
        var busStopId : String?
    }
    
    struct Response
    {
        var busStops : [BusStop]?
        var error : NSError?
    }
    
    struct ViewModel
    {
        struct BusStop
        {
            var id : String
            var title : String
            var latitude : String
            var longitude : String
            var imageURL : String
        }
        
        var busStops : [BusStop]?
        var errorMessage : String?
    }
}
