//
//  BarberAppointmentsAppApp.swift
//  BarberAppointmentsApp
//
//  Created by Rami Alaidy on 28/11/2023.
//

import SwiftUI

@main
struct BarberAppointmentsAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
