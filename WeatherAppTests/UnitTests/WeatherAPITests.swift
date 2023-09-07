//
//  WeatherAPITests.swift
//  WeatherAppTests
//
//  Created by Volodymyr Grytsenko on 07.09.23.
//

import Factory
import Foundation
import XCTest

@testable import WeatherApp

final class WeatherAPITests: WeatherTestCase {
    @LazyInjected(\MockContainer.networkDataLoader) private var networkDataLoader
    
    private var weatherAPI: WeatherDataSource!
    
    override func setUp() {
        super.setUp()
        
        weatherAPI = WeatherAPIImpl()
        networkDataLoader.dataCallCount = 0
    }
    
    private func networkDataLoaderResponse<T: Codable>(object: T, statusCode: Int) throws -> (Data, URLResponse) {
        let mockData = try JSONEncoder().encode(object)
        let mockURL = URL(string: "http://test.com")!
        let mockURLResponse = HTTPURLResponse(url: mockURL, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        return (mockData, mockURLResponse)
    }
    
    func testGetCurrentWeather_whenSuccess() async {
        let expectedValue = CurrentWeatherEntity.TestData.default
        networkDataLoader.dataHandler = { _, _ in
            return try self.networkDataLoaderResponse(object: expectedValue, statusCode: 200)
        }
        
        do {
            let receivedValue = try await weatherAPI.getCurrentWeather(coordinate: .init(latitude: 0, longitude: 0), units: .metric)
            XCTAssertEqual(networkDataLoader.dataCallCount, 1)
            XCTAssertEqual(CurrentWeather(entity: expectedValue), receivedValue)
        } catch {
            XCTFail("Failed to decode successful object")
        }
    }
    
    func testGetCurrentWeather_whenFailedWithDecode() async {
        networkDataLoader.dataHandler = { _, _ in
            return try self.networkDataLoaderResponse(object: "Shouldn't be parsed", statusCode: 200)
        }
        
        do {
            let _ = try await weatherAPI.getCurrentWeather(coordinate: .init(latitude: 0, longitude: 0), units: .metric)
            XCTFail("Request should fail with decode error")
        } catch RequestError.decode {
            XCTAssertEqual(networkDataLoader.dataCallCount, 1)
        } catch {
            XCTFail("Got a different error code")
        }
    }
    
    func testGetCurrentWeather_whenFailedWithUnauthorized() async {
        let expectedValue = CurrentWeatherEntity.TestData.default
        networkDataLoader.dataHandler = { _, _ in
            return try self.networkDataLoaderResponse(object: expectedValue, statusCode: 401)
        }
        
        do {
            let _ = try await weatherAPI.getCurrentWeather(coordinate: .init(latitude: 0, longitude: 0), units: .metric)
            XCTFail("Request should fail with unathorized error")
        } catch RequestError.unauthorized {
            XCTAssertEqual(networkDataLoader.dataCallCount, 1)
        } catch {
            XCTFail("Got a different error code")
        }
    }
    
    func testGetCurrentWeather_whenFailedWithUnexpectedStatusCode() async {
        let expectedValue = CurrentWeatherEntity.TestData.default
        networkDataLoader.dataHandler = { _, _ in
            return try self.networkDataLoaderResponse(object: expectedValue, statusCode: 404)
        }
        
        do {
            let _ = try await weatherAPI.getCurrentWeather(coordinate: .init(latitude: 0, longitude: 0), units: .metric)
            XCTFail("Request should fail with unexpected status code")
        } catch RequestError.unexpectedStatusCode {
            XCTAssertEqual(networkDataLoader.dataCallCount, 1)
        } catch {
            XCTFail("Got a different error code")
        }
    }
    
    func testGetCurrentWeather_whenFailedWithUnknown() async {
        networkDataLoader.dataHandler = { _, _ in
            throw RequestError.unknown
        }
        
        do {
            let _ = try await weatherAPI.getCurrentWeather(coordinate: .init(latitude: 0, longitude: 0), units: .metric)
            XCTFail("Request should fail with unknown error")
        } catch RequestError.unknown {
            XCTAssertEqual(networkDataLoader.dataCallCount, 1)
        } catch {
            XCTFail("Got a different error code")
        }
    }
    
    func testGetLocations_whenSuccess() async {
        let expectedValue = [LocationEntity.TestData.default]
        networkDataLoader.dataHandler = { _, _ in
            return try self.networkDataLoaderResponse(object: expectedValue, statusCode: 200)
        }
        
        do {
            let receivedValue = try await weatherAPI.getLocations(query: "Munich")
            XCTAssertEqual(networkDataLoader.dataCallCount, 1)
            XCTAssertEqual(expectedValue.map { Location(entity: $0) }, receivedValue)
        } catch {
            XCTFail("Failed to decode successful object")
        }
    }
    
    func testGetLocations_whenFailedWithDecode() async {
        networkDataLoader.dataHandler = { _, _ in
            return try self.networkDataLoaderResponse(object: "Shouldn't be parsed", statusCode: 200)
        }
        
        do {
            let _ = try await weatherAPI.getLocations(query: "Munich")
            XCTFail("Request should fail with decode error")
        } catch RequestError.decode {
            XCTAssertEqual(networkDataLoader.dataCallCount, 1)
        } catch {
            XCTFail("Got a different error code")
        }
    }
    
    func testGetLocations_whenFailedWithUnauthorized() async {
        let expectedValue = [LocationEntity.TestData.default]
        networkDataLoader.dataHandler = { _, _ in
            return try self.networkDataLoaderResponse(object: expectedValue, statusCode: 401)
        }
        
        do {
            let _ = try await weatherAPI.getLocations(query: "Munich")
            XCTFail("Request should fail with unathorized error")
        } catch RequestError.unauthorized {
            XCTAssertEqual(networkDataLoader.dataCallCount, 1)
        } catch {
            XCTFail("Got a different error code")
        }
    }
    
    func testGetLocations_whenFailedWithUnexpectedStatusCode() async {
        let expectedValue = [LocationEntity.TestData.default]
        networkDataLoader.dataHandler = { _, _ in
            return try self.networkDataLoaderResponse(object: expectedValue, statusCode: 404)
        }
        
        do {
            let _ = try await weatherAPI.getLocations(query: "Munich")
            XCTFail("Request should fail with unexpected status code")
        } catch RequestError.unexpectedStatusCode {
            XCTAssertEqual(networkDataLoader.dataCallCount, 1)
        } catch {
            XCTFail("Got a different error code")
        }
    }
    
    func testGetLocations_whenFailedWithUnknown() async {
        networkDataLoader.dataHandler = { _, _ in
            throw RequestError.unknown
        }
        
        do {
            let _ = try await weatherAPI.getLocations(query: "Munich")
            XCTFail("Request should fail with unknown error")
        } catch RequestError.unknown {
            XCTAssertEqual(networkDataLoader.dataCallCount, 1)
        } catch {
            XCTFail("Got a different error code")
        }
    }
}
