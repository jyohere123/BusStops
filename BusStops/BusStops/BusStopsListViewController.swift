//
//  BusStopsListViewController.swift
//  BusStops
//
//  Created by HM on 10/1/16.
//  Copyright (c) 2016 MyLabSolutions. All rights reserved.
//

import UIKit

private let kBusStopTableViewCellIdentifier = "BusStopCell"

protocol BusStopsListViewControllerInput
{
    func displayBusStops(viewModel: BusStopsList.ViewModel)
}

protocol BusStopsListViewControllerOutput
{
    func fetchBusStops(request: BusStopsList.Request)
}

class BusStopsListViewController: UITableViewController, BusStopsListViewControllerInput
{
    var output : BusStopsListViewControllerOutput!
    var router : BusStopsListRouter!
    var busStops : [BusStopsList.ViewModel.BusStop]?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        BusStopsListConfigurator.sharedInstance.configure(viewController: self)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.registerTableViewCells()
        self.navigationItem.title = "BusStops"
        fetchBusStops()
    }
    
    func registerTableViewCells()
    {
        let nibName = UINib(nibName: kBusStopTableViewCellIdentifier, bundle:nil)
        self.tableView.register(nibName, forCellReuseIdentifier: kBusStopTableViewCellIdentifier)
    }
    
    // MARK: BusStopsListViewControllerOutput compliance
    // Communicates with the Interactor
    func fetchBusStops()
    {
        let request = BusStopsList.Request()
        output.fetchBusStops(request: request);
    }
    
    // MARK: BusStopsListViewControllerInput compliance
    
    func displayBusStops(viewModel: BusStopsList.ViewModel)
    {
        if let viewModelBusStops = viewModel.busStops
        {
            self.populateTableViewWithBusStops(viewModelBusStops)
        }
        else if let error = viewModel.errorMessage
        {
            print("\(error)")
        }
    }
    
    func populateTableViewWithBusStops(_ viewModelBusStops : [BusStopsList.ViewModel.BusStop])
    {
        self.busStops = viewModelBusStops;
        self.tableView.reloadData();
    }
    
}

extension BusStopsListViewController
{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: kBusStopTableViewCellIdentifier, for: indexPath) as! BusStopCell
        
        cell.busStop = self.busStops![(indexPath as NSIndexPath).item]
        cell.indexPath = indexPath as NSIndexPath?
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor =  UIColor.lightGray.cgColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard let busStops = self.busStops else
        {
            return 0
        }
        return busStops.count;
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120;
    }
    
    
}
