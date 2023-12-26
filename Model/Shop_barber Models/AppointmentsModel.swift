//
//  AppointmentsModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 22/09/2023.
//

import Foundation

// MARK: - Appointments
struct Appointments: Codable {
    let phoneCustomer: String?
    let conditionAppintements: String?
    let id: Int?
    let nameCustomer: String?
    let reservationDate: ReservationDate?
    let typeAppintements: String?

    enum CodingKeys: String, CodingKey {
        case phoneCustomer = "Phone_customer"
        case conditionAppintements = "condition_appintements"
        case id = "id"
        case nameCustomer = "name_customer"
        case reservationDate = "reservation_date"
        case typeAppintements = "type_appintements"
    }
}

// MARK: - ReservationDate
struct ReservationDate: Codable {
    let dayReservation: String?
    let timeReservation: String?

    enum CodingKeys: String, CodingKey {
        case dayReservation = "day_reservation"
        case timeReservation = "time_reservation"
    }
}
