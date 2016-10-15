//
//  BusStopsListConfigurator.swift
//  BusStops
//
//  Created by HM on 10/1/16.
//  Copyright (c) 2016 MyLabSolutions. All rights reserved.
//

import UIKit

// MARK: Connect View Controller, Interactor, and Presenter

extension BusStopsListViewController: BusStopsListPresenterOutput
{
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        router.passDataToNextScene(segue)
    }
}

extension BusStopsListInteractor: BusStopsListViewControllerOutput
{
    
}

extension BusStopsListPresenter: BusStopsListInteractorOutput
{
    
}

class BusStopsListConfigurator
{
    // MARK: Object lifecycle
    
    static let sharedInstance : BusStopsListConfigurator = {
        let instance = BusStopsListConfigurator()
        return instance
    }()
    
    // MARK: Configuration
    
    func configure(viewController: BusStopsListViewController)
    {
        let router = BusStopsListRouter()
        router.viewController = viewController
        
        let presenter = BusStopsListPresenter()
        presenter.output = viewController
        
        let interactor = BusStopsListInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
