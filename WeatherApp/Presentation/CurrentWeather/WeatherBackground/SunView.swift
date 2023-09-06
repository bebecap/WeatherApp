//
//  SunView.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import Foundation
import SwiftUI

struct SunView: View {
    @Binding var sunPosition: Double?
    @Binding var cloudsOpacity: Double?
    
    @State private var sunColor: Color = Color.orange
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(
                            colors: [
                                sunColor(sunPosition: (sunPosition ?? 0)).opacity(0.3),
                                Color.clear
                            ]
                        ),
                        center: .center,
                        startRadius: 5,
                        endRadius: 200)
                    .opacity(1 - (cloudsOpacity ?? 0)))
                .position(x: UIScreen.main.bounds.width * (sunPosition ?? 0), y: getSunYPosition(sunPosition: (sunPosition ?? 0)))
            
            Circle()
                .fill(sunColor(sunPosition: (sunPosition ?? 0)).opacity(1 - (cloudsOpacity ?? 0)))
                .frame(width: 100, height: 100)
                .position(x: UIScreen.main.bounds.width * (sunPosition ?? 0), y: getSunYPosition(sunPosition: (sunPosition ?? 0)))
        }
    }
    
    func getSunYPosition(sunPosition: Double) -> CGFloat {
        let midPoint = UIScreen.main.bounds.height / 2
        let deviation = UIScreen.main.bounds.height / 4
        let position = midPoint + deviation * cos(2 * .pi * CGFloat(sunPosition))
        return position
    }
    
    func sunColor(sunPosition: Double) -> Color {
        let sunGradient = Gradient(stops: [
            Gradient.Stop(color: Color(hex: "#FF4500"), location: 0.0),
            Gradient.Stop(color: Color(hex: "#FF6347"), location: 0.1),
            Gradient.Stop(color: Color(hex: "#FF7F50"), location: 0.2),
            Gradient.Stop(color: Color(hex: "#FFD700"), location: 0.3),
            Gradient.Stop(color: Color(hex: "#FFFF00"), location: 0.4),
            Gradient.Stop(color: Color(hex: "#FFFFE0"), location: 0.5),
            Gradient.Stop(color: Color(hex: "#FFFF00"), location: 0.6),
            Gradient.Stop(color: Color(hex: "#FFD700"), location: 0.7),
            Gradient.Stop(color: Color(hex: "#FF7F50"), location: 0.8),
            Gradient.Stop(color: Color(hex: "#FF4500"), location: 0.9)
        ])
        
        let resolvedColor = sunGradient.stops[Int(sunPosition * CGFloat(sunGradient.stops.count - 1))].color
        return resolvedColor
    }
}
