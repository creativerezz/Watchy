//
//  SleepView.swift
//  Watchy Watch App
//

import SwiftUI

struct SleepView: View {
    var store: HealthStore

    private var stageTotals: [(stage: SleepStage, duration: TimeInterval)] {
        SleepStage.allCases.map { ($0, store.sleep.duration(of: $0)) }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 6) {
                Gauge(value: Double(store.sleep.score), in: 0...100) {
                    EmptyView()
                } currentValueLabel: {
                    VStack(spacing: 0) {
                        Text("\(store.sleep.score)")
                            .font(.system(.title3, design: .rounded, weight: .bold))
                        Text("score")
                            .font(.system(size: 9))
                            .foregroundStyle(.secondary)
                    }
                }
                .gaugeStyle(.circular)
                .tint(Gradient(colors: [.indigo, .purple, .blue]))
                .frame(width: 80, height: 80)

                Text(store.sleep.totalDuration.formattedHoursMinutes)
                    .font(.system(.body, design: .rounded, weight: .semibold))

                HStack {
                    Label(store.sleep.bedtime.formatted(date: .omitted, time: .shortened), systemImage: "moon.fill")
                    Spacer()
                    Label(store.sleep.wakeTime.formatted(date: .omitted, time: .shortened), systemImage: "sunrise.fill")
                }
                .font(.system(size: 9))
                .foregroundStyle(.secondary)

                SleepStageBar(session: store.sleep)
                    .frame(height: 8)
                    .padding(.top, 2)

                VStack(spacing: 4) {
                    ForEach(stageTotals, id: \.stage) { item in
                        QuickStatRow(icon: item.stage.icon, title: item.stage.label, value: item.duration.formattedHoursMinutes, tint: item.stage.color)
                    }
                }
                .padding(.top, 2)
            }
            .padding(.horizontal, 4)
            .padding(.top, 2)
        }
        .navigationTitle("Sleep")
    }
}

#Preview {
    SleepView(store: HealthStore())
}
