//
//  WeatherRepositoryTests.swift
//  WeatherAppTests
//
//  Created by Volodymyr Grytsenko on 08.09.23.
//

import Factory
import Foundation
import XCTest

@testable import WeatherApp

final class WeatherRepositoryTests: WeatherTestCase {
    @LazyInjected(\MockContainer.weatherDataSource) private var weatherDataSource
    
    private var weatherRepository: WeatherRepository!
    
    override func setUp() {
        super.setUp()
        
        weatherRepository = WeatherRepositoryImpl()
    }
    
    func testGetCurrentWeather_whenSuccess() async {
        let expectedValue = CurrentWeather.TestData.default
        weatherDataSource.getCurrentWeatherHandler = { _, _ in
            expectedValue
        }
        
        do {
            let receivedValue = try await weatherRepository.getCurrentWeather(coordinate: .init(latitude: 0, longitude: 0), units: .imperial)
            XCTAssertEqual(expectedValue, receivedValue)
            XCTAssertEqual(weatherDataSource.getCurrentWeatherCallCount, 1)
        } catch {
            XCTFail("Failed to get object")
        }
    }
    
    func testGetCurrentWeather_whenFailed() async {
        weatherDataSource.getCurrentWeatherHandler = { _, _ in
            throw RequestError.decode
        }
        
        do {
            let _ = try await weatherRepository.getCurrentWeather(coordinate: .init(latitude: 0, longitude: 0), units: .imperial)
            XCTFail("Request should fail")
        } catch RequestError.decode {
            XCTAssertEqual(weatherDataSource.getCurrentWeatherCallCount, 1)
            XCTAssertEqual(weatherDataSource.getLocationsCallCount, 0)
        } catch {
            XCTFail("Got unexpected error")
        }
    }
    
    func testGetLocations_whenSuccess() async {
        let expectedValue = [Location.TestData.default]
        weatherDataSource.getLocationsHandler = { _ in
            expectedValue
        }
        
        do {
            let receivedValue = try await weatherRepository.getLocations(query: "Munich")
            XCTAssertEqual(expectedValue, receivedValue)
            XCTAssertEqual(weatherDataSource.getCurrentWeatherCallCount, 0)
            XCTAssertEqual(weatherDataSource.getLocationsCallCount, 1)
        } catch {
            XCTFail("Failed to get object")
        }
    }
    
    func testGetLocations_whenFailed() async {
        weatherDataSource.getLocationsHandler = { _ in
            throw RequestError.decode
        }
        
        do {
            let _ = try await weatherRepository.getLocations(query: "Munich")
            XCTFail("Request should fail")
        } catch RequestError.decode {
            XCTAssertEqual(weatherDataSource.getCurrentWeatherCallCount, 0)
            XCTAssertEqual(weatherDataSource.getLocationsCallCount, 1)
        } catch {
            XCTFail("Got unexpected error")
        }
    }
}
