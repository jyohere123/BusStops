//
//  BusStopsListRouter.swift
//  BusStops
//
//  Created by HM on 10/1/16.
//  Copyright (c) 2016 MyLabSolutions. All rights reserved.
//

import UIKit

protocol BusStopsListRouterInput
{
    func navigateToBusStopsDetailScene()
}

class BusStopsListRouter: BusStopsListRouterInput
{
    weak var viewController: BusStopsListViewController!
    
    // MARK: Navigation
    
    func navigateToBusStopsDetailScene()
    {
        // NOTE: Teaching the router how to navigate to another scene.
      
    }
    
    // MARK: Communication
    func passDataToNextScene(_ segue: UIStoryboardSegue)
    {
        // NOTE: Teach the router which scenes it can communicate with
        
        if segue.identifier == "BusStopsDetailScene"
        {
            passDataToBusStopsDetailScene(segue)
        }
    }
    
    func passDataToBusStopsDetailScene(_ segue: UIStoryboardSegue)
    {
        // NOTE: Passing data to the next scene
        
    }
}
