//
//  AppleDocumentionView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 04/11/2023.
//

import SwiftUI
import MapKit

@available(iOS 17.0, *)
struct AppleDocumentionView: View {


    var cityHallLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 31.55, longitude: 35.78)

    var publicLibraryLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 31.60, longitude: 35.88)

    @State var playgroundLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 31.75, longitude: 35.98)

    var body: some View {

     Map {
         UserAnnotation()
         .mapOverlayLevel(level: .aboveRoads)

            MapCircle(center: playgroundLocation, radius: 1000_0)
                .foregroundStyle(.gray.opacity(0.5))
            Marker("San Francisco City Hall", coordinate: cityHallLocation)
                .tint(.orange)
            Marker("San Francisco Public Library", coordinate: publicLibraryLocation)
                .tint(.blue)
            Annotation("Diller Civic Center Playground", coordinate: playgroundLocation ) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.yellow)
                    Text("🛝")
                        .padding(5)
                }
            }
            .annotationTitles(.visible)
            .annotationSubtitles(.visible)
        }
     .mapStyle(.standard)
        .mapControls {
            CompassButtonTestView()
            MapUserLocationButton()
                .controlSize(.extraLarge)
                .buttonBorderShape(.circle)
                .foregroundColor(.blue)
//            LocationButtonTestView()
                MapScaleView()
                .imageScale(.small)
        }
        .mapControlVisibility(.visible)
    }
}
@available(iOS 17.0, *)
#Preview {
    AppleDocumentionView()
}

// Map User Location Button
@available(iOS 17.0, *)
struct LocationButtonTestView: View {
       @Namespace var mapScope
       var body: some View {
           ZStack {
               Map(scope: mapScope)
               MapUserLocationButton(scope: mapScope)
                   .foregroundColor(.red)
           }

           .mapScope(mapScope)

       }
   }
// Scale
@available(iOS 17.0, *)

struct ScaleTestView: View {
       @Namespace var mapScope

       var body: some View {
           ZStack(alignment: .trailing) {
               Map(scope: mapScope)
               MapScaleView(anchorEdge: .trailing,scope: mapScope)
//                   .offset(x:-10,y: -400)
           }
           .mapScope(mapScope)

           .mapControlVisibility(.visible)
       }
   }
@available(iOS 17.0, *)

#Preview {
    ScaleTestView()
}
@available(iOS 17.0, *)
struct CompassButtonTestView: View {
       @Namespace var mapScope
       var body: some View {
       VStack {
               Map(scope: mapScope)
               MapCompass(scope: mapScope)
               .controlSize(.large)
           }
           .mapScope(mapScope)
           .mapControlVisibility(.hidden)
       }
   }
