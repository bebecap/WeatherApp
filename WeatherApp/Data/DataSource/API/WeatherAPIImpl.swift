//
//  WeatherAPIImpl.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 05.09.23.
//

import Foundation

final class WeatherAPIImpl: HTTPClient, WeatherDataSource {
    func getCurrentWeather(coordinate: Coordinate, units: Units) async throws -> CurrentWeather {
        let result = await fetch(endpoint: WeatherEndpoints.currentWeather(coordinate: coordinate, units: units), responseModel: CurrentWeatherEntity.self)
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
        feelsLikeTemperature = entity.mainWeather.feelsLikeTemperature
        minimumTemperature = entity.mainWeather.minimumTemperature
        maximumTemperature = entity.mainWeather.maximumTemperature
        atmosphericPressure = entity.mainWeather.atmosphericPressure
        humidityPercentage = entity.mainWeather.humidityPercentage
        seaLevelPressure = entity.mainWeather.seaLevelPressure
        groundLevelPressure = entity.mainWeather.groundLevelPressure
        city = entity.cityName
    }
}
