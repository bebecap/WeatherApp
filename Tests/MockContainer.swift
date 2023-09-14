//
//  MockContainer.swift
//  WeatherAppTests
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import Factory
import Foundation

@testable import WeatherApp

final class MockContainer: SharedContainer {
    static let shared = MockContainer()
    var manager = ContainerManager()
    
    init() {
        self.manager.defaultScope = .singleton
    }
}

extension MockContainer {
    var networkDataLoader: Factory<NetworkDataLoaderMock> {
        self { NetworkDataLoaderMock() }
    }
    
    var locationManager: Factory<LocationManagerMock> {
        self { LocationManagerMock() }
    }
    
    var weatherDataSource: Factory<WeatherDataSourceMock> {
        self { WeatherDataSourceMock() }
    }
    
    var weatherRepository: Factory<WeatherRepositoryMock> {
        self { WeatherRepositoryMock() }
    }
    
    var getCurrentWeatherUseCase: Factory<GetCurrentWeatherUseCaseMock> {
        self { GetCurrentWeatherUseCaseMock() }
    }
    
    var getLocationsUseCase: Factory<GetLocationsUseCaseMock> {
        self { GetLocationsUseCaseMock() }
    }
}
