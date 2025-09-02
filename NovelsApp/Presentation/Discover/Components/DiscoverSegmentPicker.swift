//
//  DiscoverSegmentPicker.swift
//  NovelsApp
//
//  Created by Eilon Krauthammer on 10/08/2025.
//

import SwiftUI
import CoreKit

struct DiscoverSegmentPicker: View {
    @Binding var activeSegment: DiscoverSegment
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(DiscoverSegment.allCases, id: \.self) { segment in
                DiscoverSegmentButton(segment: segment, isActive: segment == activeSegment) {
                    activeSegment = segment
                }
            }
        }
        .padding(12)
        .modify {
            if #available(iOS 26, *) {
                $0.glassEffect()
            } else {
                $0
            }
        }
    }
}

struct DiscoverSegmentButton: View {
    let segment: DiscoverSegment
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            segment.label
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(isActive ? Color.activeBackground : Color.clear)
                .foregroundStyle(isActive ? Color.accent : .secondary)
                .font(.system(.subheadline).weight(.medium))
                .clipShape(.capsule)
                .minimumScaleFactor(0.8)
        }
    }
}
