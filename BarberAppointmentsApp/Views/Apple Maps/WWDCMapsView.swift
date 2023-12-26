//
//  WWDCMapsView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 08/11/2023.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D{
    static let saloon = CLLocationCoordinate2D(latitude: 31.89, longitude: 35.89)
}

struct WWDCMapsView: View {

    @State private var searchResults: [MKMapItem] = []
    @State private var selectedResult: MKMapItem?
    @State private var position: MapCameraPosition = .userLocation(followsHeading: true, fallback: .automatic)
    var body: some View {
        Map(position: $position){
            Annotation("Saloon", coordinate: .saloon){
                ZStack{
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(.background)
                    RoundedCorner()
                        .stroke(.secondary, lineWidth:5)
                    Image(systemName: "scissors")
                        .padding(5)
                }
            }
            .annotationTitles(.hidden)

            ForEach(searchResults, id: \.self) {result in
                Marker(item: result)
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                BeanTownButtons(searchResults: $searchResults)
                    .padding(.top)
                VStack(spacing:0) {
                    //                           if let selectedResult {
                    //                               ItemInfoView(selectedResult: selectedResult, route: route)
                    //                                   .frame(height: 128)
                    //                                   .clipShape(RoundedRectangle(cornerRadius: 10))
                    //                                   .padding([.top, .horizontal])
                    //                           }
                    //
                    //
                    //                           Buttons(position: $position, searchResults: $searchResults, visibleRegion: visibleRegion)
                    //                               .padding(.top)
                }
                Spacer()
            }
            .background(.thinMaterial)
        }
        .onChange(of: searchResults) {
                   withAnimation{
                       position = .automatic
                  }
               }
    }
}

#Preview {
    WWDCMapsView()
}

struct BeanTownButtons: View {

    @Binding var searchResults: [MKMapItem]

    var body: some View {
        HStack {
            Button {
                search(for: "barber")
            } label: {
                Label("Playgrounds", systemImage: "figure.and.child.holdinghands")
            }
            .buttonStyle(.bordered)

            Button {
                search(for: "salons")
            } label: {
                Label("salons", systemImage: "beach.umbrella")
            }
            .buttonStyle(.bordered)

            Button {
                searchResults = []
            } label: {
                Label("Trash", systemImage: "trash")
            }
            .buttonStyle(.bordered)

        }
        .labelStyle(.iconOnly)
    }
    func search(for query:String){

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(center: .saloon,span: MKCoordinateSpan(latitudeDelta: 0.02555, longitudeDelta: 0.0125)
        )
        Task{
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
}
