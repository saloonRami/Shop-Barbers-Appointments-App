//
//  LocationManager2.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 19/09/2023.
//

import Foundation
import MapKit
class LocationManager2: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion () ;
    private let manager = CLLocationManager ()
    override init() {
        super.init ()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.allowsBackgroundLocationUpdates = true
        manager.startUpdatingLocation()

    func locationManager (_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            region = MKCoordinateRegion (
                center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude:
                                                $0.coordinate.longitude),
                span: MKCoordinateSpan (latitudeDelta: 0.5, longitudeDelta: 0.5)
            )
//            self.startMonitoringGeofence(coordinate: CLLocationCoordinate2D.init(latitude: (locations.last?.coordinate.latitude)!, longitude: (locations.last?.coordinate.longitude)!))
        }
        }
    }
        func locationManager (_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
            print ("Entered geofence!")
    //          triggerAlarm(title: "Entering Task Location", body: "You have Entered the task Location") {
                print ("Alarm has been triggered")
    //            provideHapticFeedback()
    //        }
        }
        func locationManager (_ manager: CLLocationManager, didExitRegion region: CLRegion) {
            print("Exited geofence!")
    //        triggerAlarm(title: "Exiting Task Location", body: "You have exited the task Location!") {
                // Run your custom function or code here
                print ("Custom function executed on alarm trigger")
    //            provideHapticFeedback()
    //        }
        }
    func startMonitoringGeofence (coordinate : CLLocationCoordinate2D){
        let radius = 500.0 // Radius of the geofence in meters
        let region = CLCircularRegion (center: coordinate, radius: radius, identifier: "Geofence")
        region.notifyOnEntry = true
        region.notifyOnExit = true
        manager.startMonitoring(for: region)
    }
    
}
