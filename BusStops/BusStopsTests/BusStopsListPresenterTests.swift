//
//  BusStopsListPresenterTests.swift
//  BusStops
//
//  Created by HM on 10/9/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import XCTest

class BusStopsListPresenterTests: XCTestCase
{
    var sut: BusStopsListPresenter!

    override func setUp()
    {
        super.setUp()
        setupBusStopsListPresenter()
    }

    func setupBusStopsListPresenter()
    {
        sut = BusStopsListPresenter()
    }
    
    class BusStopsListPresenterOutputSpy : BusStopsListPresenterOutput
    {
        var displayBusStopsCalled = false;
        var viewModel : BusStopsList.ViewModel?
        
        func displayBusStops(viewModel: BusStopsList.ViewModel)
        {
            displayBusStopsCalled = true
            self.viewModel = viewModel
        }
    }
    
    func testDisplayBusStopsInvoked()
    {
        // Given
        let busStopsListPresenterOutputSpy = BusStopsListPresenterOutputSpy()
        sut.output = busStopsListPresenterOutputSpy
        
        // When
        let response = BusStopsList.Response(busStops: [], error: nil)
        sut.presentBusStops(response: response);
        
        // Then
        XCTAssert(busStopsListPresenterOutputSpy.displayBusStopsCalled, "displayBusStopsCalled() called by presenter");
    }
    
    func testViewModelFromPresentBusStops()
    {
        // Given
        let busStopsListPresenterOutputSpy = BusStopsListPresenterOutputSpy()
        sut.output = busStopsListPresenterOutputSpy
        
        // When
        let busStop = BusStop()
        busStop.objectID = "731"
        busStop.title = "PLZ CANTERAS"
        busStop.latitude = 41.63139435772203;
        busStop.longitude = -0.88;
        
        let response = BusStopsList.Response(busStops: [busStop], error: nil)
        
        sut.presentBusStops(response: response);
        
        // Then
        XCTAssert(busStopsListPresenterOutputSpy.displayBusStopsCalled, "displayBusStopsCalled() called by presenter");
        XCTAssertEqual(busStopsListPresenterOutputSpy.viewModel?.busStops?[0].title, "\(kBusStopNameString) PLZ CANTERAS")
        XCTAssertEqual(busStopsListPresenterOutputSpy.viewModel?.busStops?[0].id, "\(kBusStopNumberString) 731")
        XCTAssertEqual(busStopsListPresenterOutputSpy.viewModel?.busStops?[0].latitude, "41.63139435772203")
        XCTAssertEqual(busStopsListPresenterOutputSpy.viewModel?.busStops?[0].longitude, "-0.88")
    }
    
}



