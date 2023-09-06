//
//  SkyBackground.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import Foundation
import SwiftUI

struct SkyBackgroundView: View {
    @Binding var sunPosition: Double?
    @Binding var cloudsOpacity: Double?
    
    @State private var skyColor: Color = Color.blue
    
    var body: some View {
        ZStack {
            if let sunPosition {
                Rectangle()
                    .fill(.gray)
                    .edgesIgnoringSafeArea(.all)
                Rectangle()
                    .fill(skyColor(sunPosition: sunPosition).opacity(1 - (cloudsOpacity ?? 1)))
                    .edgesIgnoringSafeArea(.all)
            } else {
                Rectangle()
                    .fill(.gray)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    private func skyColor(sunPosition: Double) -> Color {
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
