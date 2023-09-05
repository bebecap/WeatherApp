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
    
    @Published var temperature: Double?
    @Published var city: String?
    @Published var isLoading: Bool = false
    @Published var units: Units = .metric
    
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.delegate = self
    }
    
    func onAppear() {
        isLoading = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 5000
        locationManager.startUpdatingLocation()
    }
}

extension CurrentWeatherViewModel: CLLocationManagerDelegate {
    @MainActor
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let userLocation = locations.first else { return }
        Task {
            let currentWeather = try await getCurrentWeatherUseCase.execute(coordinate: .init(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), units: units)
            temperature = currentWeather.temperature
            city = currentWeather.city
            isLoading = false
        }
    }
}

extension CurrentWeatherViewModel {
    static var mock: CurrentWeatherViewModel {
        let viewModel = CurrentWeatherViewModel()
        viewModel.temperature = 25
        viewModel.city = "Munich"
        return viewModel
    }
}
