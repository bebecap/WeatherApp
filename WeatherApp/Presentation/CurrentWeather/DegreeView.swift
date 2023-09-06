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
        
    var body: some View {
        VStack {
            Text(location ?? "Unknown")
                .font(.title)
            Text("\(degrees?.formatted(.number.precision(.fractionLength(0))) ?? "NaN")°" )
                .font(.title2)
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 16)
            .fill(Color.white.opacity(0.2)))
    }
}

struct DegreeView_Previews: PreviewProvider {
    static var previews: some View {
        DegreeView(degrees: .constant(25.05), location: .constant("Munich"))
    }
}

