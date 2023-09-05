//
//  CoreContainer.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import Factory
import Foundation

final class CoreContainer: SharedContainer {
    public static let shared = CoreContainer()
    public let manager: ContainerManager = ContainerManager()
}
