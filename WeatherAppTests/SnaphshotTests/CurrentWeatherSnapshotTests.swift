//
//  CurrentWeatherSnapshotTests.swift
//  WeatherAppTests
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import Foundation
import SnapshotTesting
import SwiftUI
import XCTest

@testable import WeatherApp

final class CurrentWeatherSnapshotTest: WeatherSnapshotTestCase {
    func testCurrentWeather_withNoData() {
        snapshotTest(view: CurrentWeatherView(viewModel: .TestData.noData, selectedLocation: .constant(nil)))
    }
    
    func testCurrentWeather_munichMorning() {
        snapshotTest(view: CurrentWeatherView(viewModel: .TestData.munichMorning, selectedLocation: .constant(nil)))
    }
    
    func testCurrentWeather_munichNoon() {
        snapshotTest(view: CurrentWeatherView(viewModel: .TestData.munichNoon, selectedLocation: .constant(nil)))
    }
    
    func testCurrentWeather_munichEvening() {
        snapshotTest(view: CurrentWeatherView(viewModel: .TestData.munichEvening, selectedLocation: .constant(nil)))
    }
    
    func testCurrentWeather_munichEveningCloudy() {
        snapshotTest(view: CurrentWeatherView(viewModel: .TestData.munichEveningCloudy, selectedLocation: .constant(nil)))
    }
}
