//
//  WeatherAPIImpl.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 05.09.23.
//

import Foundation

final class WeatherAPIImpl: HTTPClient, WeatherDataSource {
    func getCurrentWeather(coordinate: Coordinate, units: Units) async throws -> CurrentWeather {
        let result = await sendRequest(endpoint: WeatherEndpoints.currentWeather(coordinate: coordinate, units: units), responseModel: CurrentWeatherEntity.self)
        switch result {
        case .success(let entity):
            return CurrentWeather(entity: entity)
        case .failure(let error): throw error
        }
    }
}

fileprivate extension CurrentWeather {
    init(entity: CurrentWeatherEntity) {
        temperature = entity.mainWeather.temperature
        minTemperature = entity.mainWeather.minimumTemperature
        maxTemperature = entity.mainWeather.maximumTemperature
        status = entity.weatherConditions.first?.group
        city = entity.cityName
        sunset = Date(timeIntervalSince1970: TimeInterval(entity.system.sunsetTime))
        sunrise = Date(timeIntervalSince1970: TimeInterval(entity.system.sunriseTime))
        clouds = entity.cloudCoverage.coveragePercentage
    }
}
