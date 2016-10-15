//
//  BusStopsListViewControllerTests.swift
//  BusStops
//
//  Created by HM on 10/9/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import XCTest

class BusStopsListViewControllerTests: XCTestCase
{
    
    var sut: BusStopsListViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        window = UIWindow()
        setupProductListViewController()
    }
    
    override func tearDown()
    {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupProductListViewController()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
        sut = storyboard.instantiateViewController(withIdentifier: "BusStopsListViewController") as! BusStopsListViewController
    }
    
    func loadView()
    {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    class BusStopsListViewControllerOutputSpy : BusStopsListViewControllerOutput
    {
        // MARK: Argument expectations
        var request: BusStopsList.Request!
        
        var fetchBusStopsCalled = false
        
        // MARK: Spied methods
        func fetchBusStops(request: BusStopsList.Request)
        {
            self.fetchBusStopsCalled = true
            self.request = request
        }
        
    }
    
    func testShouldFetchProductsWhenViewIsLoaded()
    {
        // Given
        let busStopsListViewControllerOutputSpy = BusStopsListViewControllerOutputSpy()
        sut.output = busStopsListViewControllerOutputSpy
        
        // When
        loadView()
        
        // Then
        XCTAssert(busStopsListViewControllerOutputSpy.fetchBusStopsCalled , "Should fetch BusStops when the view is loaded")
    }
    
    
}
