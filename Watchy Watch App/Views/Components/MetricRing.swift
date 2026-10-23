//
//  MetricRing.swift
//  Watchy Watch App
//

import SwiftUI

struct MetricRing: View {
    let value: Double
    let range: ClosedRange<Double>
    let label: String
    let icon: String
    let tint: Color

    var body: some View {
        Gauge(value: value, in: range) {
            EmptyView()
        } currentValueLabel: {
            VStack(spacing: 1) {
                Image(systemName: icon)
                    .font(.caption2)
                    .foregroundStyle(tint)
                Text(value, format: .number.precision(.fractionLength(0)))
                    .font(.system(.footnote, design: .rounded, weight: .semibold))
                Text(label)
                    .font(.system(size: 8))
                    .foregroundStyle(.secondary)
            }
        }
        .gaugeStyle(.circular)
        .tint(tint.gradient)
        .frame(width: 70, height: 70)
    }
}
