//
//  BusStopsListWorkerTests.swift
//  BusStops
//
//  Created by HM on 10/9/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import XCTest

class BusStopsListWorkerTests: XCTestCase
{
    // MARK : System under test
    
    var sut: BusStopsListWorker!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupBusStopsListWorker()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupBusStopsListWorker()
    {
        sut = BusStopsListWorker()
    }
    
    class BusStopsListDataControllerSpy: BusStopsListDataController
    {
        // MARK: Method call expectations
        var fetchBusStopsListCalled = false
        
        // MARK: Spied methods
        override func fetchBusStopsList(_ request: BusStopsList.Request, completion: @escaping (_ data: AnyObject?, _ error: NSError?) -> Void)
        {
            fetchBusStopsListCalled = true
            let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute:
            {
                var jsonData : NSData?
                if let path = Bundle.main.path(forResource: "BusStopListTest", ofType: "json")
                {
                    do
                    {
                        jsonData = try NSData(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe)
                    }
                    catch let error as NSError
                    {
                        print(error.localizedDescription)
                    }
                }
                completion(jsonData, nil)
            })
        }
    }
    
    // MARK: Tests
    
    func testFetchBusStopsListShouldReturnListOfBusStops()
    {
        // Given
        let busStopsListDataControllerSpy = BusStopsListDataControllerSpy()
        let request = BusStopsList.Request()
        
        // When
        let expectation = self.expectation(description: "Wait for fetched BusStops result")
        sut.busStopsListDataController = busStopsListDataControllerSpy
        sut.fetchBusStops(request: request)
        {
            (busStops, error) in
            expectation.fulfill()
        }
        
        // Then
        XCTAssert(busStopsListDataControllerSpy.fetchBusStopsListCalled, "Called fetchBusStopsList() of DataController ")
        waitForExpectations(timeout: 1.1) { error in
            XCTAssert(true, "Calling fetchBusStopsList() should result in the completion handler being called with the fetched BusStopss result")
        }
    }
    
    func testFetchBusStopsListReturnedByWorker()
    {
        // Given
        let busStopsListDataControllerSpy = BusStopsListDataControllerSpy()
        let request = BusStopsList.Request()
        
        // When
        let expectation = self.expectation(description: "Wait for fetched BusStops result")
        sut.busStopsListDataController = busStopsListDataControllerSpy
        var busStopsArray : [BusStop]?
        sut.fetchBusStops(request: request)
        {
            (busStops, error) in
            
                busStopsArray = busStops
                expectation.fulfill()
            
        }
        
        // Then
        XCTAssert(busStopsListDataControllerSpy.fetchBusStopsListCalled, "Calling fetchBusStopsList() of DataController ")
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertEqual(busStopsArray?.count, 1)
            XCTAssertEqual(busStopsArray?[0].objectID, "731")
            XCTAssertEqual(busStopsArray?[0].title, "PLZ CANTERAS")
            XCTAssertEqual(busStopsArray?[0].latitude, 41.63139435772203)
            XCTAssertEqual(busStopsArray?[0].longitude, -0.886143585091619)
        }
    }

    
    
}
