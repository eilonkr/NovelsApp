//
//  View+Helpers.swift
//  AIRecipe
//
//  Created by Eilon Krauthammer on 15/07/2025.
//

import SwiftUI
import CoreKit

extension View {
    func maxWidth(_ width: CGFloat = 500, alignment: Alignment = .center) -> some View {
        frame(maxWidth: width, alignment: alignment)
    }
    
    func cornerRadius(style: CornerRadiusStyle, strokeColor: Color, strokeWidth: CGFloat, dash: [CGFloat] = [1]) -> some View {
        clipShape(RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
                    .stroke(style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round, lineJoin: .round, dash: dash))
                    .foregroundStyle(strokeColor)
            }
    }

    func cornerRadius(style: CornerRadiusStyle, strokeStyle: some ShapeStyle, strokeWidth: CGFloat, dash: [CGFloat] = [1]) -> some View {
        clipShape(RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
                    .stroke(style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round, lineJoin: .round, dash: dash))
                    .foregroundStyle(strokeStyle)
            }
    }
    
    func alert(title: LocalizedStringResource,
               message: LocalizedStringResource? = nil,
               cta: LocalizedStringResource = "OK",
               isPresented: Binding<Bool>,
               action: @escaping () -> Void = { }) -> some View {
        alert(Text(title), isPresented: isPresented, actions: {
            Button(action: action) {
                Text(cta)
            }
        }, message: {
            if let message {
                Text(message)
            }
        })
    }

    /// Applies a linear gradient mask to the view, creating a fade effect from opaque to transparent.
    ///
    /// - Parameters:
    ///   - start: The starting point of the gradient (e.g., `.top`, `.leading`).
    ///   - end: The ending point of the gradient (e.g., `.bottom`, `.trailing`).
    ///   - from: The location in the gradient where the mask starts to fade out, specified as a value between `0` and `1`. Defaults to `0`.
    ///   - to: The location in the gradient where the mask becomes fully transparent, specified as a value between `0` and `1`. Defaults to `1`.
    ///
    /// - Returns: A view masked with a linear gradient, allowing for custom fade effects at specified edges or points.
    func fadeMask(start: UnitPoint, end: UnitPoint, from: CGFloat = 0, to: CGFloat = 1) -> some View {
        mask {
            LinearGradient(stops: [.init(color: .black, location: from),
                                   .init(color: .black.opacity(0), location: to)],
                           startPoint: start,
                           endPoint: end)
        }
    }
}
