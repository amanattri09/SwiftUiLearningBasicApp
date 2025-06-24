//
//  LocationManager.swift
//  FirebaseSwiftUIExample
//
//  Created by Aman Attri on 24/06/25.
//

import Foundation
import CoreLocation

class LocationManager : NSObject , ObservableObject , CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var location : CLLocation?
    @Published var authorizationStatus : CLAuthorizationStatus?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy  = kCLLocationAccuracyBest
        if(hasLocationPermission()){
            manager.startUpdatingLocation()
        }
    }
    
    func checkIfLocationServicesIsEnabled(){
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled(){
                self.checkLocationAuthorization()
            }else{
                // show message: Services desabled!
            }
        }
    }
    
    private func checkLocationAuthorization(){
        switch manager.authorizationStatus {
        case .notDetermined:
            print("not determined")
            manager.requestWhenInUseAuthorization()
        case .restricted:
            print("restrited service")
        case .denied:
            print("restrited service")
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        default:
            break
        }
    }
    
    func hasLocationPermission() -> Bool{
        return manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways
    }
    
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("locationManagerDidChangeAuthorization")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }
}
