//
//  ResponseParser.swift
//  BusStops
//
//  Created by HM on 10/1/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import Foundation

class ResponseParser
{
    static func parseBusStops(data : AnyObject?) -> [BusStop]?
    {
        var busStopsArray : Array<BusStop>?
        do
        {
            let object = try JSONSerialization.jsonObject(with: data! as! Data, options: .allowFragments)
            if let dictionary = object as? [String: AnyObject]
            {
                busStopsArray = Array()
                let busStops = dictionary["locations"]  as? [NSDictionary]
                
                for busStopDictionary in busStops!
                {
                    let busStopObj = parseBusStop(busStopDictionary: busStopDictionary)
                    busStopsArray!.append(busStopObj);
                }
            }
        }
        catch
        {
            //Have to log the exception
        }
        
        return busStopsArray
    }
    
    static func parseBusStop(busStopDictionary: NSDictionary) -> BusStop
    {
        let busStopObj = BusStop()
        
        busStopObj.objectID = busStopDictionary["id"] as? String
        busStopObj.title = busStopDictionary["title"] as? String
        busStopObj.latitude = busStopDictionary["lat"] as? NSNumber
        busStopObj.longitude = busStopDictionary["lon"] as? NSNumber
        
        return busStopObj
    }
    
}
