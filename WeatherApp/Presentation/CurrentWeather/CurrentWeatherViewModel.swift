//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import CoreLocation
import Factory
import Foundation

final class CurrentWeatherViewModel: NSObject, ObservableObject {
    @LazyInjected(\CoreContainer.getCurrentWeatherUseCase) private var getCurrentWeatherUseCase
    @LazyInjected(\CoreContainer.locationManager) private var locationManager
    
    var currentWeather: CurrentWeather? {
        didSet {
            temperature = currentWeather?.temperature
            city = currentWeather?.city
            minTemperature = currentWeather?.minTemperature
            maxTemperature = currentWeather?.maxTemperature
            status = currentWeather?.status
            cloudsOpacity = Double(currentWeather?.clouds ?? 0) / 100
            calculateSunPosition()
        }
    }
    
    @Published var temperature: Double?
    @Published var city: String?
    @Published var cloudsOpacity: Double?
    @Published var isLoading: Bool = false
    @Published var units: Units = .metric
    @Published var sunPosition: Double? = nil
    @Published var minTemperature: Double? = 0
    @Published var maxTemperature: Double? = 0
    @Published var status: String?
    
    private var timer: Timer?

    func onAppear() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.calculateSunPosition()
        }
        isLoading = true
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 5000
        locationManager.startUpdatingLocation()
    }
    
    private func calculateSunPosition() {
        guard let currentWeather else { return }
        self.sunPosition = sunPosition(currentDate: Date(), sunrise: currentWeather.sunrise, sunset: currentWeather.sunset)
    }
    
    private func sunPosition(currentDate: Date, sunrise: Date, sunset: Date) -> Double? {
        let elapsedSinceSunrise = currentDate.timeIntervalSince(sunrise)
        let daylightDuration = sunset.timeIntervalSince(sunrise)

        if elapsedSinceSunrise < 0 { return 0 } // Before sunrise
        if elapsedSinceSunrise > daylightDuration { return 1 } // After sunset

        return elapsedSinceSunrise / daylightDuration
    }
}

extension CurrentWeatherViewModel: CLLocationManagerDelegate {
    @MainActor
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locationManager.location else { return }
        Task {
            currentWeather = try await getCurrentWeatherUseCase.execute(coordinate: .init(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), units: units)
            isLoading = false
        }
    }
}
