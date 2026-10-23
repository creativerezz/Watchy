//
//  VitalsView.swift
//  Watchy Watch App
//

import SwiftUI

struct VitalsView: View {
    var store: HealthStore
    @State private var pulse = false

    var body: some View {
        ScrollView {
            VStack(spacing: 6) {
                Gauge(value: store.vitals.heartRate, in: store.vitals.heartRateRange) {
                    EmptyView()
                } currentValueLabel: {
                    VStack(spacing: 1) {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                            .scaleEffect(pulse ? 1.15 : 0.95)
                            .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: pulse)
                        Text(store.vitals.heartRate, format: .number.precision(.fractionLength(0)))
                            .font(.system(.title3, design: .rounded, weight: .bold))
                        Text("BPM")
                            .font(.system(size: 9))
                            .foregroundStyle(.secondary)
                    }
                }
                .gaugeStyle(.circular)
                .tint(Gradient(colors: [.pink, .red]))
                .frame(width: 84, height: 84)
                .onAppear { pulse = true }

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 6) {
                    StatTile(icon: "waveform.path.ecg", title: "HRV", value: "\(Int(store.vitals.hrv))", unit: "ms", tint: .green)
                    StatTile(icon: "lungs.fill", title: "SpO₂", value: "\(Int(store.vitals.oxygenSaturation))", unit: "%", tint: .cyan)
                    StatTile(icon: "wind", title: "Resp.", value: String(format: "%.1f", store.vitals.respiratoryRate), unit: "br/min", tint: .teal)
                    StatTile(icon: "thermometer.medium", title: "Wrist", value: String(format: "%+.1f", store.vitals.wristTemperatureDelta), unit: "°C", tint: .orange)
                }
            }
            .padding(.top, 2)
        }
        .navigationTitle("Vitals")
    }
}

#Preview {
    VitalsView(store: HealthStore())
}
