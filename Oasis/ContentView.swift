//
//  ContentView.swift
//  Oasis
//
//  Created by Ezra Carrillo on 2/12/25.
// elhadji 

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // San Francisco
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    var body: some View {
        VStack {
            Text("Hello, world!")
                .font(.title)
                .padding()

            Map(coordinateRegion: $region) // SwiftUI Map View
                .frame(height: 300) // Adjust the height
                .cornerRadius(10)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
