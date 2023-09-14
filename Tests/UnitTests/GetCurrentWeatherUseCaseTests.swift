//
//  GetCurrentWeatherUseCaseTests.swift
//  WeatherAppTests
//
//  Created by Volodymyr Grytsenko on 08.09.23.
//

import Factory
import Foundation
import XCTest

@testable import WeatherApp

final class GetCurrentWeatherUseCaseTests: WeatherTestCase {
    @LazyInjected(\MockContainer.weatherRepository) private var weatherRepository
    
    private var getCurrentWeatherUseCase: GetCurrentWeatherUseCase!
    
    override func setUp() {
        super.setUp()
        
        getCurrentWeatherUseCase = GetCurrentWeatherUseCaseImpl()
    }
    
    func testExecute_whenSuccess() async {
        let expectedValue = CurrentWeather.TestData.default
        weatherRepository.getCurrentWeatherHandler = { _, _ in
            expectedValue
        }
        
        do {
            let receivedValue = try await getCurrentWeatherUseCase.execute(coordinate: .init(latitude: 0, longitude: 0), units: .imperial)
            XCTAssertEqual(expectedValue, receivedValue)
            XCTAssertEqual(weatherRepository.getCurrentWeatherCallCount, 1)
            XCTAssertEqual(weatherRepository.getLocationsCallCount, 0)
        } catch {
            XCTFail("Failed to get object")
        }
    }
    
    func testExecute_whenFailed() async {
        weatherRepository.getCurrentWeatherHandler = { _, _ in
            throw RequestError.decode
        }
        
        do {
            let _ = try await getCurrentWeatherUseCase.execute(coordinate: .init(latitude: 0, longitude: 0), units: .imperial)
            XCTFail("Request should fail")
        } catch RequestError.decode {
            XCTAssertEqual(weatherRepository.getCurrentWeatherCallCount, 1)
            XCTAssertEqual(weatherRepository.getLocationsCallCount, 0)
        } catch {
            XCTFail("Got unexpected error")
        }
    }
}
