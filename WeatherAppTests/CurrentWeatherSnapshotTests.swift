//
//  CurrentWeatherSnapshotTests.swift
//  WeatherAppTests
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import CoreLocation
import Factory
import Foundation
import SnapshotTesting
import SwiftUI
import XCTest

@testable import WeatherApp

final class CurrentWeatherSnapshotTest: WeatherSnapshotTestCase {
    @LazyInjected(\MockContainer.locationManager) var locationManager
    @LazyInjected(\MockContainer.getCurrentWeatherUseCase) var getCurrentWeatherUseCase
    
    private func snapshotTest(view: CurrentWeatherView, testName: String = #function) {
        let hostingController = UIHostingController(rootView: view)
        hostingController.view.frame = UIScreen.main.bounds
        assertSnapshot(of: hostingController.view, as: .image, testName: testName)
    }
    
    func testCurrentWeather_withNoData() {
        snapshotTest(view: CurrentWeatherView(viewModel: .TestData.noData))
    }
    
    func testCurrentWeather_munichMorning() {
        snapshotTest(view: CurrentWeatherView(viewModel: .TestData.munichMorning))
    }
    
    func testCurrentWeather_munichNoon() {
        snapshotTest(view: CurrentWeatherView(viewModel: .TestData.munichNoon))
    }
    
    func testCurrentWeather_munichEvening() {
        snapshotTest(view: CurrentWeatherView(viewModel: .TestData.munichEvening))
    }
    
    func testCurrentWeather_munichEveningCloudy() {
        snapshotTest(view: CurrentWeatherView(viewModel: .TestData.munichEveningCloudy))
    }
}
