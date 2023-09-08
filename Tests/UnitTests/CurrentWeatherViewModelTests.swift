//
//  CurrentWeatherViewModelTests.swift
//  WeatherAppTests
//
//  Created by Volodymyr Grytsenko on 08.09.23.
//

import Factory
import Foundation
import XCTest

@testable import WeatherApp

final class CurrentWeatherViewModelTests: WeatherTestCase {
    @LazyInjected(\MockContainer.getCurrentWeatherUseCase) private var getCurrentWeatherUseCase
    @LazyInjected(\MockContainer.locationManager) private var locationManager
    
    private var viewModel: CurrentWeatherViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = CurrentWeatherViewModel()
    }
    
    func testOnAppear() {
        viewModel.onAppear()
        
        XCTAssertEqual(locationManager.delegateSetCallCount, 1)
        XCTAssertEqual(locationManager.requestWhenInUseAuthorizationCallCount, 1)
        XCTAssertEqual(locationManager.distanceFilterSetCallCount, 1)
        XCTAssertEqual(locationManager.distanceFilter, 5000)
        XCTAssertEqual(locationManager.startUpdatingLocationCallCount, 1)
        XCTAssertEqual(locationManager.stopUpdatingLocationCallCount, 0)
    }
    
    func testSelectedLocation_whenCurrentLocation() async {
        do {
            try await viewModel.updateSelectedLocation(nil)
        } catch {
            XCTFail("Unexpected error")
        }
        
        XCTAssertEqual(locationManager.startUpdatingLocationCallCount, 1)
        XCTAssertEqual(locationManager.stopUpdatingLocationCallCount, 0)
        XCTAssertEqual(getCurrentWeatherUseCase.executeCallCount, 0)
    }
    
    func testSelectedLocation_whenPickedLocationAndSuccess() async {
        getCurrentWeatherUseCase.executeHandler = { _, _ in
            .TestData.default
        }
        
        do {
            try await viewModel.updateSelectedLocation(.TestData.default)
        } catch {
            XCTFail("Unexpected error")
        }
        
        XCTAssertEqual(locationManager.startUpdatingLocationCallCount, 0)
        XCTAssertEqual(locationManager.stopUpdatingLocationCallCount, 1)
        XCTAssertEqual(getCurrentWeatherUseCase.executeCallCount, 1)
        XCTAssertNil(viewModel.errorText)
    }
    
    func testSelectedLocation_whenPickedLocationAndFail() async {
        getCurrentWeatherUseCase.executeHandler = { _, _ in
            throw RequestError.decode
        }
        
        do {
            try await viewModel.updateSelectedLocation(.TestData.default)
        } catch {
            XCTFail("Unexpected error")
        }
        
        XCTAssertEqual(locationManager.startUpdatingLocationCallCount, 0)
        XCTAssertEqual(locationManager.stopUpdatingLocationCallCount, 1)
        XCTAssertEqual(getCurrentWeatherUseCase.executeCallCount, 1)
        XCTAssertNotNil(viewModel.errorText)
    }
}
