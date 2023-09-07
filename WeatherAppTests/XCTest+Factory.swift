//
//  WeatherTestCase.swift
//  WeatherAppTests
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import Factory
import Foundation
import XCTest
@testable import WeatherApp

class WeatherTestCase: XCTestCase {
    private var containers: [any SharedContainer] = [CoreContainer.shared]
    
    override func setUp() {
        super.setUp()
        for container in containers {
            container.manager.push()
        }
        registerMocks()
    }
    
    override func tearDown() {
        super.tearDown()
        Scope.singleton.reset()
        
        for container in containers {
            container.manager.reset()
            container.manager.pop()
        }
    }
    
    private func registerMocks() {
        CoreContainer.shared.networkDataLoader.register {
            MockContainer.shared.networkDataLoader()
        }
        
        CoreContainer.shared.weatherDataSource.register {
            MockContainer.shared.weatherDataSource()
        }
        
        CoreContainer.shared.weatherRepository.register {
            MockContainer.shared.weatherRepository()
        }
        
        CoreContainer.shared.getCurrentWeatherUseCase.register {
            MockContainer.shared.getCurrentWeatherUseCase()
        }
        
        CoreContainer.shared.getLocationsUseCase.register {
            MockContainer.shared.getLocationsUseCase()
        }
        
        CoreContainer.shared.locationManager.register {
            MockContainer.shared.locationManager()
        }
    }
}

class WeatherSnapshotTestCase: WeatherTestCase {}
