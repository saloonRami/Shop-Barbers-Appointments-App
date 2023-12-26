//
//  LocationManager.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 19/09/2023.
//

import Foundation
import MapKit
import _MapKit_SwiftUI
import SwiftUI

//import SwiftProtobuf


@MainActor final class LocationManager: NSObject, ObservableObject {
//    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))

    @Published var region = MKCoordinateRegion(
        center: .init(latitude: 33.883_591_5, longitude: 35.891_484_0),
        span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    private let locationManager = CLLocationManager()
    var delegate: MKMapViewDelegate?
//    var selectableMapFeatures: MKMapFeatureOptions

//    @Published var region = MKCoordinateRegion () ;
//    private let manager = CLLocationManager ()
    override init() {
        super.init()
        self.delegate = self

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization ()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
        self.setup()



    }

    func setup() {
        switch locationManager.authorizationStatus {
        //If we are authorized then we request location just once, to center the map
        case .authorizedWhenInUse:
            locationManager.requestLocation()
            locationManager.allowsBackgroundLocationUpdates = true
        //If we don´t, we request authorization
        case .notDetermined:
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.requestLocation()
        case .authorizedAlways:
            locationManager.requestAlwaysAuthorization()
        case .denied:
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
            locationManager.requestLocation()
        case .authorized:
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        case .restricted:
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        default:
            break
        }
    }

}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        guard .authorizedWhenInUse == manager.authorizationStatus else { return }
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()

        locations.last.map {
            region = MKCoordinateRegion(
                center: $0.coordinate,
                span: .init(latitudeDelta: 0.7, longitudeDelta: 0.7)
            )
            Marker(coordinate: $0.coordinate) {
//                Label("Latvian Freedom Monument")
            }
//            startMonitoringGeofence(coordinate: locations.last!.coordinate)
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
        let radius = 1000.0 // Radius of the geofence in meters
        let region = CLCircularRegion (center: coordinate, radius: radius, identifier: "Geofence")
        region.contains(coordinate)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        locationManager.startMonitoring(for: region)
    }
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        print(mapView.region)
    }
}
extension LocationManager: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        print(oldState)
        print(newState)
        print(view.annotation?.coordinate as Any)
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view)
    }
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        print(mode)
    }
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        print(views.first?.annotation?.coordinate as Any)
    }
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(animated)
    }
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print(userLocation)
    }
}
