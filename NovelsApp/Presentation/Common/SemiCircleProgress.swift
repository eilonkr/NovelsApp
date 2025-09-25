//
//  SemiCircleProgress.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 25/09/2025.
//

import SwiftUI

struct SemiCircleProgress: Shape {
    var progress: Double
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let c = CGPoint(x: rect.midX, y: rect.maxY)
        path.addArc(center: c,
                    radius: rect.width / 2,
                    startAngle: .degrees(-180),
                    endAngle: .degrees(-180 + (180 * progress)),
                    clockwise: false)
        
        return path
    }
}

struct SemiCircleProgressView: View {
    let progress: Double
    
    @State private var value = 0.0
    
    var body: some View {
        ZStack {
            // Background semi-circle (non-filled part)
            SemiCircleProgress(progress: 1.0)
                .stroke(Color(.systemGray6), style: StrokeStyle(lineWidth: 6, lineCap: .round))
            
            // Progress semi-circle (filled part)
            SemiCircleProgress(progress: value)
                .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 6, lineCap: .round))
        }
        .task {
            try? await Task.sleep(for: .seconds(2))
            
            withAnimation(.smooth(duration: 0.5)) {
//                value = progress
                value = 0.6
            }
        }
    }
}
