//
//  AnnotationItem.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 04/11/2023.
//

import Foundation
import CoreLocation

struct AnnotationItem: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
