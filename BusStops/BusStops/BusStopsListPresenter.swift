//
//  BusStopsListPresenter.swift
//  BusStops
//
//  Created by HM on 10/1/16.
//  Copyright (c) 2016 MyLabSolutions. All rights reserved.
//

import UIKit

protocol BusStopsListPresenterInput
{
    func presentBusStops(response: BusStopsList.Response)
}

protocol BusStopsListPresenterOutput: class
{
    func displayBusStops(viewModel: BusStopsList.ViewModel)
}

class BusStopsListPresenter: BusStopsListPresenterInput
{
    weak var output: BusStopsListPresenterOutput!
    
    // MARK: Presentation logic
    
    func presentBusStops(response: BusStopsList.Response)
    {
        // Formatting the response from the Interactor and passing the result back to the View Controller
        
        var viewModel = BusStopsList.ViewModel();
        if let busStops = response.busStops
        {
            var viewModelBusStops: [BusStopsList.ViewModel.BusStop] = []
            for busStop in busStops
            {
                let id = "\(kBusStopNumberString) \(busStop.objectID!)"
                let title = "\(kBusStopNameString) \(busStop.title!)"
                let latitude = "\(busStop.latitude!)"
                let longitude = "\(busStop.longitude!)"
                let imageURL = "http://maps.googleapis.com/maps/api/staticmap?center=\(latitude),\(longitude)&zoom=15&size=200x120&sensor=true"
                
                let viewModelBusStop = BusStopsList.ViewModel.BusStop(id: id, title: title, latitude: latitude, longitude: longitude, imageURL: imageURL)
                viewModelBusStops.append(viewModelBusStop)
            }
            viewModel.busStops = viewModelBusStops;
            output.displayBusStops(viewModel: viewModel)
        }
        else if let error = response.error
        {
            viewModel.errorMessage = error.localizedDescription
            output.displayBusStops(viewModel: viewModel)
        }
    }
}
