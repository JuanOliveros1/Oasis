//
//  MapViewModel.swift
//  Oasis
//
//  Created by Ezra Carrillo on 3/20/25.
//

import MapKit

enum MapDetails {
    static let startingLoaction = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    
}


final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var region = MKCoordinateRegion(
        center:(MapDetails.startingLoaction),
        span:(MapDetails.defaultSpan)
    )
    var locationManager: CLLocationManager?
    
    func CheckIfLocationServicesEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            
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
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                        span: (MapDetails.defaultSpan))
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorizationStatus()
    }
    func recenter() {
        guard let location = locationManager?.location else {
            print("Location is not available")
            return
        }

        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: location.coordinate,
                span: MapDetails.defaultSpan
            )
        }
    }

}
