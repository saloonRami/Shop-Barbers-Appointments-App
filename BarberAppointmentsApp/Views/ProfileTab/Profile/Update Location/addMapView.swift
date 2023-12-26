//
//  addMapView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 27/09/2023.
//

import SwiftUI
import CoreLocation
import MapKit
import Firebase

struct addMapView: View {
    @EnvironmentObject var manager : LocationManager
    @EnvironmentObject var LocationVM : LocationViewModel
    var coordinate: CLLocationCoordinate2D
       @State  var region = MKCoordinateRegion()
    @State  var regionMarker = MKMapItem()

    @Binding var IsshowsUserLocation : Bool
    var body: some View {

        Map(coordinateRegion: $manager.region, interactionModes: .all, showsUserLocation: true,userTrackingMode: .constant(.none))

            .task(priority: .high, {
//                self.manager = LocationManager()
                if coordinate.latitude != 0{

                    setRegion(coordinate)
                    self.manager.startMonitoringGeofence(coordinate: CLLocationCoordinate2D(latitude: 32.8835915, longitude: 34.5914840))
                    self.addLpcationToFirebase(Coordinate: coordinate)

                }
            })
    }
       private func setRegion(_ coordinate: CLLocationCoordinate2D) {
           region = MKCoordinateRegion(
               center: coordinate,
               span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
           )
       }

    func addLpcationToFirebase( Coordinate: CLLocationCoordinate2D){
        Auth.auth().addStateDidChangeListener { auth, user in
            print(auth,user as Any)

            if (user != nil) {
                let ref = Database.database().reference()
                let userOwnerID = user?.uid
                //                guard self.BarberModel.urlAutoID != nil else {return}
                let itemsRef = ref.child("Shop_barber").child(userOwnerID!).child("Shop_info").child("Location_shop")
                let post = [
                    "name": user?.displayName ?? "",
                    "email": user?.email ?? "",
                    "latitude": Coordinate.latitude,
                    "longitude": Coordinate.longitude
                ]
//                let post = [
//                    "latitude": Coordinate.latitude,
//                    "longitude": Coordinate.longitude
//                ]
                itemsRef.updateChildValues(post as [AnyHashable : Any])
            }
        }
    }
   }

struct addMapView_Previews: PreviewProvider {
    static var previews: some View {
        addMapView(coordinate: .init(latitude: 32.8835915, longitude: 34.5914840), IsshowsUserLocation: .constant(true))
            .environmentObject(LocationManager())

    }
}

struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}
