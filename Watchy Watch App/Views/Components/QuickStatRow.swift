//
//  QuickStatRow.swift
//  Watchy Watch App
//

import SwiftUI

struct QuickStatRow: View {
    let icon: String
    let title: String
    let value: String
    var tint: Color = .secondary

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(tint)
                .frame(width: 18)
            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.caption2.weight(.semibold))
        }
    }
}
