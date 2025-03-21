//
//  MapViewModel.swift
//  Oasis
//
//  Created by Ezra Carrillo on 3/20/25.
//
import SwiftUI
import MapKit

enum MapDetails {
    static let startingLoaction = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    
}


final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: MapDetails.startingLoaction,
            span: MapDetails.defaultSpan
        )
    )

    @Published var userLocation: CLLocationCoordinate2D?
    
    var locationManager: CLLocationManager?
    
    func CheckIfLocationServicesEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.startUpdatingLocation()
            
        } else {
            print("Show an alert Letting them know location services are not enabled")
        }
    }
    
    private func checkLocationAuthorizationStatus(){
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls")
        case .denied:
            print("You have denied this app location permission.")
        case .authorizedAlways, .authorizedWhenInUse:
            if let location = locationManager.location {
                DispatchQueue.main.async {
                    self.cameraPosition = .region(
                        MKCoordinateRegion(
                            center: location.coordinate,
                            span: MapDetails.defaultSpan
                        )
                    )
                    self.userLocation = location.coordinate
                    
                }
            }
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorizationStatus()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        DispatchQueue.main.async {
            self.userLocation = location.coordinate
            
        }
    }
    func recenter() {
        guard let coordinate = self.userLocation else {
            print(" Location not yet available")
            return
        }
        

        DispatchQueue.main.async {
            self.cameraPosition = .region(
                MKCoordinateRegion(
                    center: coordinate,
                    span: MapDetails.defaultSpan
                )
            )
            print("Map recentered to user location:", coordinate)
        }
    }

}

struct UserLocationPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
