//
//  SleepStageBar.swift
//  Watchy Watch App
//

import SwiftUI

struct SleepStageBar: View {
    let session: SleepSession

    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 1.5) {
                ForEach(session.segments) { segment in
                    Capsule()
                        .fill(segment.stage.color.gradient)
                        .frame(width: max(2, geo.size.width * CGFloat(segment.duration / session.totalDuration)))
                }
            }
        }
        .clipShape(Capsule())
    }
}
