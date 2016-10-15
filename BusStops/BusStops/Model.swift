//
//  Model.swift
//  BusStops
//
//  Created by HM on 10/1/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import Foundation
import UIKit

class BaseBusStop : NSObject
{
    var objectID : String?
}

class BusStop : BaseBusStop
{
    var title : String?
    var latitude : NSNumber?
    var longitude : NSNumber?
    
    override var description: String
    {
        return "id: \(objectID) \n title: \(title) \n latitude: \(latitude) \n  longitude: \(longitude) \n"
    }
}


