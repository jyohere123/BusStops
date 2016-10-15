//
//  BusStopsListInteractorTests.swift
//  BusStops
//
//  Created by HM on 10/9/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import XCTest

class BusStopsListInteractorTests: XCTestCase
{
    // MARK: System under test
    
    var sut: BusStopsListInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupBusStopsListInteractor()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupBusStopsListInteractor()
    {
        sut = BusStopsListInteractor()
    }
    
    class BusStopsListInteractorOutputSpy : BusStopsListInteractorOutput
    {
        // MARK: Method call expectations
        
        var presentBusStopsCalled = false
        
        // MARK: Spied methods
        func presentBusStops(response: BusStopsList.Response)
        {
            presentBusStopsCalled = true
        }
    }
    
    class BusStopsListWorkerSpy : BusStopsListWorker
    {
        // MARK: Method call expectations
        var fetchBusStopsCalled = false
        
        // MARK: Spied methods
        override func fetchBusStops(request: BusStopsList.Request, completionHandler: @escaping (_ busStops: [BusStop]?,  _ error: NSError?) -> ())
        {
            fetchBusStopsCalled = true
            let busStop = BusStop()
            busStop.objectID = "731"
            busStop.title = "PLZ CANTERAS"
            busStop.latitude = 41.63139435772203;
            busStop.longitude = -0.886143585091619;
            completionHandler([busStop], nil)
        }
    }
    
    func testWorkerFetchBusStopsInvoked()
    {
        // Given
        let busStopsListWorkerSpy = BusStopsListWorkerSpy()
        sut.worker = busStopsListWorkerSpy
        let busStopsListInteractorOutputSpy = BusStopsListInteractorOutputSpy()
        sut.output = busStopsListInteractorOutputSpy
        
        // When
        let request = BusStopsList.Request()
        sut.fetchBusStops(request: request)
        
        // Then
        XCTAssert(busStopsListWorkerSpy.fetchBusStopsCalled, "fetchBusStops() should ask BusStopsListWorker to fetch BusStops")
    }
    
    func testPresenterPresentBusStopsInvoked()
    {
        // Given
        let busStopsListInteractorOutputSpy = BusStopsListInteractorOutputSpy()
        sut.output = busStopsListInteractorOutputSpy
        let busStopsListWorkerSpy = BusStopsListWorkerSpy()
        sut.worker = busStopsListWorkerSpy
        
        // When
        let request = BusStopsList.Request()
        sut.fetchBusStops(request: request)
        
        // Then
        XCTAssert(busStopsListInteractorOutputSpy.presentBusStopsCalled, "fetchBusStops() should ask presenter to format BusStops result")
    }
}
