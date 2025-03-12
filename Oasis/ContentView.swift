//
//  ContentView.swift
//  Oasis
//
//  Created by Ezra Carrillo on 2/12/25.
// elhadji

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 29.7199, longitude: -95.3422), // University of Houston
        span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))

    var body: some View {
    VStack {
    // Top Bar
    Text("Oasis")
//                HStack {
//                    Text("Oasis")
//                        .font(.title)
//                        .bold()
//                        .foregroundColor(.white)
//                        .padding()
//                    Spacer()
//                }
//                .frame(height: 50) // Adjust height as needed
//                .background(Color.white.opacity(0.8)) // Example background color
//                .foregroundColor(.white)

    // Map View
    Map(coordinateRegion: $region)
                    .edgesIgnoringSafeArea(.horizontal)
                    .frame(maxHeight: .infinity) // Make the map take up all available space

    // Bottom Bar
    HStack {
    Text("Bottom Bar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
    Spacer()
}
                .frame(height: 100)
                .background(Color.white.opacity(0.8))
                .foregroundColor(.white)
}
            .edgesIgnoringSafeArea(.bottom) // Ignore safe area for full screen effect
}
}

#Preview {
    ContentView()
}
