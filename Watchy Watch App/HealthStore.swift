//
//  HealthStore.swift
//  Watchy Watch App
//

import Foundation
import Observation

@Observable
final class HealthStore {
    private(set) var vitals: VitalsSnapshot
    private(set) var sleep: SleepSession

    private var timer: Timer?

    init() {
        vitals = VitalsSnapshot(
            heartRate: 68,
            hrv: 42,
            oxygenSaturation: 98,
            respiratoryRate: 15,
            wristTemperatureDelta: 0.1
        )
        sleep = Self.sampleSleepSession()
    }

    func startMonitoring() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }

    func stopMonitoring() {
        timer?.invalidate()
        timer = nil
    }

    private func tick() {
        vitals.heartRate = (vitals.heartRate + Double.random(in: -4...4)).clamped(to: 52...150)
        vitals.hrv = (vitals.hrv + Double.random(in: -2...2)).clamped(to: 15...90)
        vitals.oxygenSaturation = (vitals.oxygenSaturation + Double.random(in: -0.4...0.4)).clamped(to: 92...100)
        vitals.respiratoryRate = (vitals.respiratoryRate + Double.random(in: -0.6...0.6)).clamped(to: 10...22)
    }

    private static func sampleSleepSession() -> SleepSession {
        let calendar = Calendar.current
        let wake = calendar.date(bySettingHour: 6, minute: 42, second: 0, of: Date()) ?? Date()
        let bedtime = calendar.date(byAdding: .hour, value: -7, to: wake) ?? Date()
        let segments: [SleepSegment] = [
            SleepSegment(stage: .awake, duration: 6 * 60),
            SleepSegment(stage: .core, duration: 95 * 60),
            SleepSegment(stage: .rem, duration: 25 * 60),
            SleepSegment(stage: .core, duration: 70 * 60),
            SleepSegment(stage: .deep, duration: 55 * 60),
            SleepSegment(stage: .core, duration: 60 * 60),
            SleepSegment(stage: .rem, duration: 35 * 60),
            SleepSegment(stage: .core, duration: 40 * 60),
            SleepSegment(stage: .awake, duration: 4 * 60)
        ]
        return SleepSession(bedtime: bedtime, wakeTime: wake, segments: segments, score: 84)
    }
}

private extension Double {
    func clamped(to range: ClosedRange<Double>) -> Double {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
