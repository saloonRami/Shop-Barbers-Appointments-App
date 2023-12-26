//
//  MapView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 04/11/2023.
//

import SwiftUI
import MapKit
import CoreLocation

struct AppleMapView: View {

    @StateObject private var viewModel = MapViewModel()

    private let address: AddressResult

    init(address: AddressResult) {
        self.address = address
    }

    var body: some View {

        Map(
            coordinateRegion: $viewModel.region,
            annotationItems: viewModel.annotationItems,
            annotationContent: { item in
                MapMarker(coordinate: item.coordinate)
            }
        )

        .onAppear {
            self.viewModel.getPlace(from: address)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
#Preview {
    AppleMapView(address: AddressResult(title: "rami", subtitle: "mu location"))

}
import MapKit
import CoreLocation

struct Train:Identifiable{
    var id = UUID()
    var runNumber: Int
    var position: CLLocation
}
struct MapView: View {
    @Binding var train: Train
    @Binding var region: MKCoordinateRegion
    @Binding var marker: MapMarker

    var body: some View {
        Map(coordinateRegion: $region, interactionModes: .zoom, annotationItems: [train], annotationContent: { _ in
            return marker
        })
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("Train #\(train.runNumber)")
    }
}
struct MapView_Previews: PreviewProvider {

    @State static var train = sampleTrain1
    @State static var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: sampleTrain1.position.coordinate.latitude, longitude: sampleTrain1.position.coordinate.longitude), latitudinalMeters: 1000, longitudinalMeters: 1000)
    @State static var marker = MapMarker(coordinate: region.center)

    static var previews: some View {
        NavigationView {
            MapView(train: $train, region: $region, marker: $marker)
        }
    }
}
let sampleTrain1 =  Train(runNumber: 10, position: CLLocation(latitude: 31.99, longitude: 35.89))

