//
//  ContentView.swift
//  Watchy Watch App
//
//  Created by Reza J. on 10/14/26.
//

import SwiftUI

struct ContentView: View {
    @State private var store = HealthStore()
    @State private var selection: Tab = .overview

    private enum Tab: Hashable {
        case overview, vitals, sleep
    }

    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                OverviewView(store: store)
                    .tag(Tab.overview)
                    .containerBackground(.black.gradient, for: .tabView)

                VitalsView(store: store)
                    .tag(Tab.vitals)
                    .containerBackground(Color.red.opacity(0.35).gradient, for: .tabView)

                SleepView(store: store)
                    .tag(Tab.sleep)
                    .containerBackground(Color.indigo.opacity(0.4).gradient, for: .tabView)
            }
            .tabViewStyle(.verticalPage)
        }
        .task {
            store.startMonitoring()
        }
    }
}

#Preview {
    ContentView()
}
