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
    
    func testLocationManagerDidUpdateLocations() {
        let expectation = XCTestExpectation(description: "Waiting for response")
        locationManager.location = .init(latitude: 0, longitude: 0)

        getCurrentWeatherUseCase.executeHandler = { _, _ in
            defer {
                expectation.fulfill()
            }
            return .TestData.default
        }
        
        viewModel.locationManager(.init(), didUpdateLocations: [])
        
        wait(for: [expectation])
        
        XCTAssertEqual(locationManager.startUpdatingLocationCallCount, 0)
        XCTAssertEqual(locationManager.stopUpdatingLocationCallCount, 0)
        XCTAssertEqual(getCurrentWeatherUseCase.executeCallCount, 1)
        XCTAssertNil(viewModel.errorText)
    }
    
    func testLocationManagerDidUpdateLocations_whenNoLocation() {
        locationManager.location = nil
    
        viewModel.locationManager(.init(), didUpdateLocations: [])
        
        XCTAssertEqual(locationManager.startUpdatingLocationCallCount, 0)
        XCTAssertEqual(locationManager.stopUpdatingLocationCallCount, 0)
        XCTAssertEqual(getCurrentWeatherUseCase.executeCallCount, 0)
        XCTAssertNil(viewModel.errorText)
    }
    
    func testRetry_whenSuccess() async {
        let expectation = XCTestExpectation(description: "Waiting for response")
        locationManager.location = .init(latitude: 0, longitude: 0)

        getCurrentWeatherUseCase.executeHandler = { _, _ in
            defer {
                expectation.fulfill()
            }
            return .TestData.default
        }
        
        await viewModel.retry()
        
        await fulfillment(of: [expectation])
        
        XCTAssertEqual(locationManager.startUpdatingLocationCallCount, 0)
        XCTAssertEqual(locationManager.stopUpdatingLocationCallCount, 0)
        XCTAssertEqual(getCurrentWeatherUseCase.executeCallCount, 1)
        XCTAssertNil(viewModel.errorText)
    }
    
    func testRetry_whenNoLocation() async {
        let expectation = XCTestExpectation(description: "Waiting for response")
        locationManager.location = nil
        
        await viewModel.retry()
        
        XCTAssertEqual(locationManager.startUpdatingLocationCallCount, 0)
        XCTAssertEqual(locationManager.stopUpdatingLocationCallCount, 0)
        XCTAssertEqual(getCurrentWeatherUseCase.executeCallCount, 0)
        XCTAssertEqual(viewModel.errorText, "No location to fetch the data")
    }
    
    func testRetry_whenFailed() async {
        let expectation = XCTestExpectation(description: "Waiting for response")
        locationManager.location = .init(latitude: 0, longitude: 0)

        getCurrentWeatherUseCase.executeHandler = { _, _ in
            defer {
                expectation.fulfill()
            }
            throw RequestError.unauthorized
        }
        
        await viewModel.retry()
        
        await fulfillment(of: [expectation])
        
        XCTAssertEqual(locationManager.startUpdatingLocationCallCount, 0)
        XCTAssertEqual(locationManager.stopUpdatingLocationCallCount, 0)
        XCTAssertEqual(getCurrentWeatherUseCase.executeCallCount, 1)
        XCTAssertEqual(RequestError.unauthorized.localizedDescription, viewModel.errorText)
    }
}
