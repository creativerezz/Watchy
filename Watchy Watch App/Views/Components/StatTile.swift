//
//  StatTile.swift
//  Watchy Watch App
//

import SwiftUI

struct StatTile: View {
    let icon: String
    let title: String
    let value: String
    let unit: String
    let tint: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Image(systemName: icon)
                .font(.caption2)
                .foregroundStyle(tint)
            Text(valueWithUnit)
            Text(title)
                .font(.system(size: 9))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(6)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
    }

    private var valueWithUnit: AttributedString {
        var result = AttributedString(value)
        result.font = .system(.body, design: .rounded, weight: .semibold)

        var unitPart = AttributedString(" \(unit)")
        unitPart.font = .system(size: 9)
        unitPart.foregroundColor = .secondary

        return result + unitPart
    }
}
