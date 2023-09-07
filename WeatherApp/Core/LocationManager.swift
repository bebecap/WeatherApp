//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import CoreLocation
import Foundation

/// @mockable
protocol LocationManager {
    var location: CLLocation? { get }
    var distanceFilter: CLLocationDistance { get set }
    var delegate: CLLocationManagerDelegate? { get set }
    
    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
    func stopUpdatingLocation()
}

extension CLLocationManager: LocationManager {}
