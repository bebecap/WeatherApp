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
    
    private var currentWeather: CurrentWeather? {
        didSet {
            temperature = currentWeather?.temperature
            city = currentWeather?.city
            cloudsOpacity = Double(currentWeather?.clouds ?? 0) / 100
        }
    }
    
    @Published var temperature: Double?
    @Published var city: String?
    @Published var cloudsOpacity: Double?
    @Published var isLoading: Bool = false
    @Published var units: Units = .metric
    @Published var sunPosition: Double? = nil
    
    private var timer: Timer?
    
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.delegate = self
    }
    
    func onAppear() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.calculateSunPosition()
        }
        isLoading = true
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
        
        guard let userLocation = locations.first else { return }
        Task {
            currentWeather = try await getCurrentWeatherUseCase.execute(coordinate: .init(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), units: units)
            calculateSunPosition()
            isLoading = false
        }
    }
}

extension CurrentWeatherViewModel {
    static var mock: CurrentWeatherViewModel {
        let viewModel = CurrentWeatherViewModel()
        viewModel.temperature = 25
        viewModel.city = "Munich"
        viewModel.sunPosition = 0.35
        return viewModel
    }
}
