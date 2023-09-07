//
//  CoreContainer.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import CoreLocation
import Factory
import Foundation

final class CoreContainer: SharedContainer {
    public static let shared = CoreContainer()
    public let manager: ContainerManager = ContainerManager()
    
    var networkDataLoader: Factory<NetworkDataLoader> {
        self { URLSession.shared }
    }
    
    var locationManager: Factory<LocationManager> {
        self { CLLocationManager() }.singleton
    }
}
