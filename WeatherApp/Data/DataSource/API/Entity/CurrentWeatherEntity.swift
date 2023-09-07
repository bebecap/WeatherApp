//
//  CurrentWeatherEntity.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 05.09.23.
//

import Foundation

struct CurrentWeatherEntity: Codable {
    let coordinates: CoordinateEntity
    let weatherConditions: [WeatherConditionEntity]
    let base: String
    let mainWeather: MainWeatherEntity
    let visibility: Int
    let wind: WindInformationEntity
    let rain: PrecipitationEntity?
    let snow: PrecipitationEntity?
    let cloudCoverage: CloudCoverageEntity
    let dataTime: Int
    let system: SystemInformationEntity
    let timezoneOffset: Int
    let cityId: Int
    let cityName: String
    let code: Int

    enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case weatherConditions = "weather"
        case base
        case mainWeather = "main"
        case visibility
        case wind
        case rain
        case snow
        case cloudCoverage = "clouds"
        case dataTime = "dt"
        case system = "sys"
        case timezoneOffset = "timezone"
        case cityId = "id"
        case cityName = "name"
        case code = "cod"
    }
}

struct CoordinateEntity: Codable {
    let longitude: Double
    let latitude: Double

    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

struct WeatherConditionEntity: Codable {
    let id: Int
    let group: String
    let conditionDescription: String
    let iconIdentifier: String

    enum CodingKeys: String, CodingKey {
        case id
        case group = "main"
        case conditionDescription = "description"
        case iconIdentifier = "icon"
    }
}

struct MainWeatherEntity: Codable {
    let temperature: Double
    let feelsLikeTemperature: Double
    let minimumTemperature: Double
    let maximumTemperature: Double
    let atmosphericPressure: Int
    let humidityPercentage: Int
    let seaLevelPressure: Int?
    let groundLevelPressure: Int?

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLikeTemperature = "feels_like"
        case minimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
        case atmosphericPressure = "pressure"
        case humidityPercentage = "humidity"
        case seaLevelPressure = "sea_level"
        case groundLevelPressure = "grnd_level"
    }
}

struct WindInformationEntity: Codable {
    let speed: Double
    let directionDegrees: Int
    let gustSpeed: Double?
    
    enum CodingKeys: String, CodingKey {
        case speed
        case directionDegrees = "deg"
        case gustSpeed = "gust"
    }
}

struct PrecipitationEntity: Codable {
    let lastHourVolume: Double?
    let lastThreeHoursVolume: Double?
    
    enum CodingKeys: String, CodingKey {
        case lastHourVolume = "1h"
        case lastThreeHoursVolume = "3h"
    }
}

struct CloudCoverageEntity: Codable {
    let coveragePercentage: Int
    
    enum CodingKeys: String, CodingKey {
        case coveragePercentage = "all"
    }
}

struct SystemInformationEntity: Codable {
    let id: Int?
    let type: Int?
    let country: String?
    let sunriseTime: Int
    let sunsetTime: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case country
        case sunriseTime = "sunrise"
        case sunsetTime = "sunset"
    }
}
