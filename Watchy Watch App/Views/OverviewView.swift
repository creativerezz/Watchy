//
//  OverviewView.swift
//  Watchy Watch App
//

import SwiftUI

struct OverviewView: View {
    var store: HealthStore

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("Today")
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                HStack(spacing: 14) {
                    MetricRing(
                        value: store.vitals.heartRate,
                        range: store.vitals.heartRateRange,
                        label: "BPM",
                        icon: "heart.fill",
                        tint: .red
                    )
                    MetricRing(
                        value: Double(store.sleep.score),
                        range: 0...100,
                        label: "Sleep",
                        icon: "bed.double.fill",
                        tint: .indigo
                    )
                }

                VStack(spacing: 6) {
                    QuickStatRow(icon: "waveform.path.ecg", title: "HRV", value: "\(Int(store.vitals.hrv)) ms", tint: .green)
                    QuickStatRow(icon: "lungs.fill", title: "SpO₂", value: "\(Int(store.vitals.oxygenSaturation))%", tint: .cyan)
                    QuickStatRow(icon: "moon.zzz.fill", title: "Last night", value: store.sleep.totalDuration.formattedHoursMinutes, tint: .indigo)
                }
                .padding(.top, 2)
            }
            .padding(.horizontal, 4)
        }
        .navigationTitle("Watchy")
    }
}

#Preview {
    OverviewView(store: HealthStore())
}
