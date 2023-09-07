//
//  DegreeView.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import Foundation
import SwiftUI

struct DegreeView: View {
    @Binding var degrees: Double?
    @Binding var location: String?
    @Binding var minTemparature: Double?
    @Binding var maxTemperature: Double?
    @Binding var status: String?
        
    var body: some View {
        VStack(spacing: 8) {
            Text(location ?? "Unknown")
                .font(.title2)
            Text("\(degrees?.formatted(.number.precision(.fractionLength(0))) ?? "NaN")°" )
                .font(.largeTitle)
            if let status {
                Text(status)
            }
            HStack {
                Text("H: \((maxTemperature ?? 0).formatted(.number.precision(.fractionLength(0))))°")
                
                Text("L: \((minTemparature ?? 0).formatted(.number.precision(.fractionLength(0))))°")
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 16)
            .fill(Color.white.opacity(0.2)))
    }
}

struct DegreeView_Previews: PreviewProvider {
    static var previews: some View {
        DegreeView(
            degrees: .constant(25.05),
            location: .constant("Munich"),
            minTemparature: .constant(17),
            maxTemperature: .constant(26),
            status: .constant("Cloudy")
        )
    }
}

