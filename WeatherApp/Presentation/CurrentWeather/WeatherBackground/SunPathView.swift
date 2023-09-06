//
//  SunPathView.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import Foundation
import SwiftUI

struct WeatherBackgroundView: View {
    @Binding var sunPosition: Double?
    @Binding var cloudsOpacity: Double?
    
    @State private var sunColor: Color = Color.orange
    @State private var skyColor: Color = Color.blue
    @State private var cloudsOffset: Double = 0

    var body: some View {
        SkyBackgroundView(sunPosition: $sunPosition, cloudsOpacity: $cloudsOpacity)
        
        SunView(sunPosition: $sunPosition, cloudsOpacity: $cloudsOpacity)
        
        CloudsView(cloudsOpacity: $cloudsOpacity)
    }
}

struct WeatherBackgroundView_Previews: PreviewProvider {
    
    static var previews: some View {
        ForEach(0..<10) { index in
            WeatherBackgroundView(sunPosition: .constant(Double(index)/10), cloudsOpacity: .constant(0.1))
                .previewDisplayName("Stop \(index)")
        }
    }
}
