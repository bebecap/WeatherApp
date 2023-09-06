//
//  CloudsView.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import Foundation
import SwiftUI

struct CloudsView: View {
    @Binding var cloudsOpacity: Double?
    
    @State private var cloudsOffset: Double = 0

    var body: some View {
        ZStack {
            CloudShape()
                .fill(Color.white.opacity(cloudsOpacity ?? 0))
                .frame(width: 300, height: 150)
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 4)
                .offset(x: cloudsOffset)
                .onAppear {
                    animateClouds()
                }
            
            CloudShape()
                .fill(Color.white.opacity(cloudsOpacity ?? 0))
                .frame(width: 250, height: 125)
                .position(x: UIScreen.main.bounds.width / 4, y: UIScreen.main.bounds.height / 3)
                .offset(x: -cloudsOffset)
                .onAppear {
                    animateClouds()
                }
        }
    }

    func animateClouds() {
        withAnimation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
            cloudsOffset = 50
        }
    }
}

struct CloudShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.addRoundedRect(in: CGRect(x: rect.width * 0.2, y: rect.height * 0.3, width: rect.width * 0.6, height: rect.height * 0.7), cornerSize: CGSize(width: rect.width * 0.3, height: rect.height * 0.7))
        
        path.addEllipse(in: CGRect(x: 0, y: rect.height * 0.4, width: rect.width * 0.35, height: rect.height * 0.6))
        path.addEllipse(in: CGRect(x: rect.width * 0.15, y: rect.height * 0.15, width: rect.width * 0.4, height: rect.height * 0.6))
        
        return path
    }
}
