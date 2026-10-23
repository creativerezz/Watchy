//
//  HealthModels.swift
//  Watchy Watch App
//

import SwiftUI

struct VitalsSnapshot {
    var heartRate: Double
    var heartRateRange: ClosedRange<Double> = 40...180
    var hrv: Double
    var oxygenSaturation: Double
    var respiratoryRate: Double
    var wristTemperatureDelta: Double
}

enum SleepStage: String, CaseIterable, Identifiable {
    case awake, rem, core, deep

    var id: String { rawValue }

    var label: String {
        switch self {
        case .awake: "Awake"
        case .rem: "REM"
        case .core: "Core"
        case .deep: "Deep"
        }
    }

    var icon: String {
        switch self {
        case .awake: "eye.fill"
        case .rem: "waveform.path"
        case .core: "moon.fill"
        case .deep: "moon.zzz.fill"
        }
    }

    var color: Color {
        switch self {
        case .awake: .orange
        case .rem: .mint
        case .core: .indigo
        case .deep: .blue
        }
    }
}

struct SleepSegment: Identifiable {
    let id = UUID()
    let stage: SleepStage
    let duration: TimeInterval
}

struct SleepSession {
    var bedtime: Date
    var wakeTime: Date
    var segments: [SleepSegment]
    var score: Int

    var totalDuration: TimeInterval {
        wakeTime.timeIntervalSince(bedtime)
    }

    func duration(of stage: SleepStage) -> TimeInterval {
        segments.filter { $0.stage == stage }.reduce(0) { $0 + $1.duration }
    }
}

extension TimeInterval {
    var formattedHoursMinutes: String {
        let totalMinutes = Int((self / 60).rounded())
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return hours > 0 ? "\(hours)h \(minutes)m" : "\(minutes)m"
    }
}
