//
//  CurrentWeatherViewModel+TestData.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 07.09.23.
//

import Foundation

extension CurrentWeatherViewModel {
    enum TestData {
        static var munichMorning: CurrentWeatherViewModel {
            let viewModel = CurrentWeatherViewModel()
            viewModel.city = "Munich"
            viewModel.cloudsOpacity = 0.2
            viewModel.temperature = 23
            viewModel.sunPosition = 0.3
            viewModel.maxTemperature = 27
            viewModel.minTemperature = 21
            viewModel.status = "Cloudy"
            return viewModel
        }
        
        static var munichNoon: CurrentWeatherViewModel {
            let viewModel = CurrentWeatherViewModel()
            viewModel.city = "Munich"
            viewModel.cloudsOpacity = 0.1
            viewModel.temperature = 26
            viewModel.sunPosition = 0.55
            viewModel.maxTemperature = 27
            viewModel.minTemperature = 21
            viewModel.status = "Cloudy"
            return viewModel
        }
        
        static var munichEvening: CurrentWeatherViewModel {
            let viewModel = CurrentWeatherViewModel()
            viewModel.city = "Munich"
            viewModel.cloudsOpacity = 0.1
            viewModel.temperature = 22
            viewModel.sunPosition = 0.8
            viewModel.maxTemperature = 27
            viewModel.minTemperature = 21
            viewModel.status = "Cloudy"
            return viewModel
        }
        
        static var munichEveningCloudy: CurrentWeatherViewModel {
            let viewModel = CurrentWeatherViewModel()
            viewModel.city = "Munich"
            viewModel.cloudsOpacity = 0.9
            viewModel.temperature = 22
            viewModel.sunPosition = 0.8
            viewModel.maxTemperature = 27
            viewModel.minTemperature = 21
            viewModel.status = "Cloudy"
            return viewModel
        }
        
        static var error: CurrentWeatherViewModel {
            let viewModel = CurrentWeatherViewModel()
            viewModel.errorText = "No location"
            return viewModel
        }
        
        static let noData: CurrentWeatherViewModel = .init()
    }
}
