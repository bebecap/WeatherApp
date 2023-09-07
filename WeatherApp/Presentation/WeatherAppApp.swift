//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 05.09.23.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    private let currentWeatherViewModel = CurrentWeatherViewModel()
    private let locationSearchViewModel = LocationSearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            FlipCardView(currentWeatherViewModel: currentWeatherViewModel, locationSearchViewModel: locationSearchViewModel)
        }
    }
}
