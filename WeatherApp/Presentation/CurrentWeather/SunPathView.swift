//
//  SunPathView.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import Foundation
import SwiftUI

struct SunPathView: View {
    @Binding var sunPosition: Double?
    @State private var sunColor: Color = Color.orange
    @State private var skyColor: Color = Color.blue

    var body: some View {
        ZStack {
            if let sunPosition {
                Rectangle()
                    .fill(skyColor(sunPosition: sunPosition))
                    .edgesIgnoringSafeArea(.all)
                
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(
                                colors: [
                                    sunColor(sunPosition: sunPosition).opacity(0.3),
                                    Color.clear
                                ]
                            ),
                            center: .center,
                            startRadius: 5,
                            endRadius: 200))
                    .position(x: UIScreen.main.bounds.width * sunPosition, y: getSunYPosition(sunPosition: sunPosition))
                
                Circle()
                    .fill(sunColor(sunPosition: sunPosition))
                    .frame(width: 100, height: 100)
                    .position(x: UIScreen.main.bounds.width * sunPosition, y: getSunYPosition(sunPosition: sunPosition))
            } else {
                Rectangle()
                    .fill(.gray)
                    .edgesIgnoringSafeArea(.all)
            }
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
    
    func skyColor(sunPosition: Double) -> Color {
        let skyGradient = Gradient(stops: [
            Gradient.Stop(color: Color(hex: "#001F3F"), location: 0.0),
            Gradient.Stop(color: Color(hex: "#003366"), location: 0.1),
            Gradient.Stop(color: Color(hex: "#0047B3"), location: 0.2),
            Gradient.Stop(color: Color(hex: "#0074D9"), location: 0.3),
            Gradient.Stop(color: Color(hex: "#7FDBFF"), location: 0.4),
            Gradient.Stop(color: Color(hex: "#87CEEB"), location: 0.5),
            Gradient.Stop(color: Color(hex: "#1E90FF"), location: 0.6),
            Gradient.Stop(color: Color(hex: "#FF6347"), location: 0.7),
            Gradient.Stop(color: Color(hex: "#4B0082"), location: 0.8),
            Gradient.Stop(color: Color(hex: "#000080"), location: 0.9)
        ])
        
        let resolvedColor = skyGradient.stops[Int(sunPosition * CGFloat(skyGradient.stops.count - 1))].color
        return resolvedColor
    }
}

struct SunFullView_Previews: PreviewProvider {
    
    static var previews: some View {
        ForEach(0..<10) { index in
            SunPathView(sunPosition: .constant(Double(index)/10))
                .previewDisplayName("Stop \(index)")
        }
    }
}
