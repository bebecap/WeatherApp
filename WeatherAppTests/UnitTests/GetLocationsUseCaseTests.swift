//
//  GetLocationsUseCaseTests.swift
//  WeatherAppTests
//
//  Created by Volodymyr Grytsenko on 08.09.23.
//

import Factory
import Foundation
import XCTest

@testable import WeatherApp

final class GetLocationsUseCaseTests: WeatherTestCase {
    @LazyInjected(\MockContainer.weatherRepository) private var weatherRepository
    
    private var getLocationsUseCase: GetLocationsUseCase!
    
    override func setUp() {
        super.setUp()
        
        getLocationsUseCase = GetLocationsUseCaseImpl()
        weatherRepository.getLocationsCallCount = 0
        weatherRepository.getCurrentWeatherCallCount = 0
    }
    
    func testExecute_whenSuccess() async {
        let expectedValue = [Location.TestData.default]
        weatherRepository.getLocationsHandler = { _ in
            expectedValue
        }
        
        do {
            let receivedValue = try await getLocationsUseCase.execute(query: "Munich")
            XCTAssertEqual(expectedValue, receivedValue)
            XCTAssertEqual(weatherRepository.getCurrentWeatherCallCount, 0)
            XCTAssertEqual(weatherRepository.getLocationsCallCount, 1)
        } catch {
            XCTFail("Failed to get object")
        }
    }
    
    func testExecute_whenFailed() async {
        weatherRepository.getLocationsHandler = { _ in
            throw RequestError.decode
        }
        
        do {
            let _ = try await getLocationsUseCase.execute(query: "Munich")
            XCTFail("Request should fail")
        } catch RequestError.decode {
            XCTAssertEqual(weatherRepository.getCurrentWeatherCallCount, 0)
            XCTAssertEqual(weatherRepository.getLocationsCallCount, 1)
        } catch {
            XCTFail("Got unexpected error")
        }
    }
}
