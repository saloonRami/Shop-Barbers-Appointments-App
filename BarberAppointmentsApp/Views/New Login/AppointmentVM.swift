//
//  AppointmentVM.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 16/09/2023.
//


import Foundation
import Combine
import Firebase

class AppointmentVM:ObservableObject{

    // for start and end
    @Published var valueStartDate: Date = Date.now
    @Published var StartvalueTime: Date = Date.today
    @Published var EndvalueTimeDuture: Date = Date.today

    //
    @Published var DaysOffString : [String] = []
    @Published var valueTime: Date = Date.today
    @Published var valueTimeDuture: Date = Date.today

    var AfterOneDay = DateComponents(  timeZone: TimeZone(identifier: "Asia/Amman")!)
    var hoursByDay = DateComponents(  timeZone: TimeZone(identifier: "Asia/Amman")!)
    var hoursByDay2 = DateComponents(  timeZone: TimeZone(identifier: "Asia/Amman")!)

//    var dayOff : String = ""
    var TimeString :[String] = []
    var dayOff : dayOffNum = .Friday
    let userCalendar = Calendar.current
    var relaxingSuntoryTimesDateComponents = DateComponents(
        timeZone: TimeZone(identifier: "Asia/Amman")!,
        weekday: 7
    )
    var dateFormatter: DateFormatter {

        let Formatter = DateFormatter()
        Formatter.dateFormat = "hh:mm a"
        return Formatter
    }
    

    @Published var User_barberModel: UserBarberValue?
    var ref: DatabaseReference!
    let userId = Auth.auth().currentUser


    // Mange Service and Price
     var  numberOfServices : Int 

    @State var nameService : [String] = Array(repeating: "", count:  8)
    @State var priceService:  [Int]
    @State var TimeService: [Int]


    init(numberOfServices:Int) {
        let relaxingSuntoryTimesDate = userCalendar.date(from: relaxingSuntoryTimesDateComponents)!
        print("Thursday on the 27th week of 2020 at 9:00 p.m. Tokyo time is \(relaxingSuntoryTimesDate.description(with: Locale(identifier: "en-US"))).")
//        self.dayOff. = "\(relaxingSuntoryTimesDate.description(with: Locale(identifier: "en-US")))"
        self.numberOfServices = numberOfServices
        self.nameService = Array(repeating: "", count:  3)
        self.priceService = Array(repeating: 0, count:  self.numberOfServices)
        self.TimeService = Array(repeating: 0, count:  self.numberOfServices)

        self.GetDataDayOffString()
        self.GetUserBareberProfile()

    }
    func GetUserBareberProfile(){

        self.ref = Database.database().reference()
        guard let userIdOwner = Auth.auth().currentUser?.uid else{return}
        ref.child(" User_Barber").child(userIdOwner).observeSingleEvent(of: .value, with: { snapshot in

            Task {
                var dataJson =  Data()
                do{
                    let dic =  snapshot.value as? NSDictionary
                    dataJson = try JSONSerialization.data (withJSONObject: dic?.allValues as Any , options: [.fragmentsAllowed])
                    let decodeData = JSONDecoder()
                    let BarberData = try decodeData.decode(UserBarberValue.self, from: dataJson)
                    self.User_barberModel = BarberData
                }catch{

                }
            }
        })
        { error in
            print(error.localizedDescription)
        }
    }

    func GetDataDayOffString(){
        for model in dayOffNum.allCases{
            self.DaysOffString += [model.getStringDayOff()]
        }
    }

    var  AddBreakTime : [String]{
        
        self.TimeString.removeAll()
        let alexanderGrahamBellDateComponents = Calendar.current.dateComponents([.year, .month,.weekday,.weekdayOrdinal,.weekOfMonth,.weekOfYear,.yearForWeekOfYear, .day,.hour,.minute,.timeZone],from: valueTime)
        hoursByDay.day = alexanderGrahamBellDateComponents.day!
        hoursByDay.hour = alexanderGrahamBellDateComponents.hour!
        hoursByDay.minute = alexanderGrahamBellDateComponents.minute
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short


        let SevenDay = userCalendar.date(from: hoursByDay)!
        let userCalenders = ["\(dateFormatter.string(from:SevenDay))"]
        self.TimeString += userCalenders

        var ToDateHoure = Calendar.current.dateComponents([.year, .month,.weekday,.weekdayOrdinal,.weekOfMonth,.weekOfYear,.yearForWeekOfYear, .day,.hour,.minute,.timeZone],from: valueTimeDuture)

        hoursByDay2.day = ToDateHoure.day!
        hoursByDay2.hour = ToDateHoure.hour!
        hoursByDay2.minute = ToDateHoure.minute
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short

        let SevenDay2 = userCalendar.date(from: hoursByDay2)!
        let userCalenders2 = ["\(dateFormatter.string(from:SevenDay2))"]
        self.TimeString += userCalenders2


        var Gethourse = ToDateHoure.hour! - alexanderGrahamBellDateComponents.hour!
        var GetMinuts = ToDateHoure.minute! - alexanderGrahamBellDateComponents.minute!

        if Double(Gethourse).sign == .minus{
            ToDateHoure.hour = ToDateHoure.hour! + 1
            Gethourse = ToDateHoure.hour! - alexanderGrahamBellDateComponents.hour!
        }
        
        if  Double(GetMinuts).sign == .minus{
            Gethourse = Gethourse - 1
            GetMinuts = 60  + GetMinuts
        }

        self.TimeString += [" Duration: - \(Gethourse) Hourse and \(GetMinuts) Minuts"]
//        The set time for lunch is: from  \(self.TimeString.first ?? "") To \(TimeString.last ?? "") 
        return TimeString
    }


    func AddServiceToDataBase(userOwnerID:String,nameService:String,priceService:String,TimeService:String,index:Int){

        Auth.auth().addStateDidChangeListener { auth, user in
            print(auth,user as Any)
            if (user != nil) {
                let ref = Database.database().reference()
                guard  self.User_barberModel?.childByAutoID != nil  else{ return}

                let itemsRef = ref.child("Shop_barber").child(user?.uid ?? "").child("Barber").child(self.User_barberModel!.childByAutoID!).child("manage_services")
                itemsRef.removeAllObservers()
                let post = [
                    "\(index)": [
                    "name_service": nameService,
                    "price_service":priceService,
                    "TimeDuration_service":TimeService
                ]
            ]
                itemsRef.updateChildValues(post as [AnyHashable : Any])
            }
        }
    }
}

import SwiftUI
import Combine
final class DateAndTimeStore: ObservableObject {

    @Published var User_barberModel: UserBarberValue?
    var ref: DatabaseReference!
    let userId = Auth.auth().currentUser


    init() {
        UserDefaults.standard.register(defaults: [
            "view.Appointment.StartDateAppointment" : Date.now.string(),
            "view.Appointment.EndDateAppointment" : Date.today.string(),
            "view.Appointment.daysReservation" : 7,
            "view.Appointment.dayOffSelect" : 6
        ])
        GetUserBareberProfile()
    }
    @Published var StartDateAppointment : String = (UserDefaults.standard.string(forKey: "view.Appointment.StartDateAppointment") ?? "" ) {
        didSet {
            UserDefaults.standard.set(StartDateAppointment, forKey: "view.Appointment.StartDateAppointment")
        }
    }

    @Published var endDateAppointment : String = (UserDefaults.standard.string(forKey: "view.Appointment.EndDateAppointment") ?? "") {
        didSet {
            UserDefaults.standard.set(endDateAppointment, forKey: "view.Appointment.EndDateAppointment")
        }
    }
    @Published var daysReservation : Int = (UserDefaults.standard.integer(forKey: "view.Appointment.daysReservation") ) {
        didSet {
            UserDefaults.standard.set(daysReservation, forKey: "view.Appointment.daysReservation")
        }
    }

    @Published  var dayOff: dayOffNum = dayOffNum(type: UserDefaults.standard.integer(forKey: "view.Appointment.dayOffSelect")) {
        didSet {
            UserDefaults.standard.set(dayOff.rawValue, forKey: "view.Appointment.dayOffSelect")
        }
        
    }
    var SaveStartDate : Date{

        let isoDate = self.StartDateAppointment
        let dateFormatterISo = ISO8601DateFormatter()
        let dateISO = dateFormatterISo.date(from: isoDate)
        let d =   dateISO?.formatted(date: .omitted, time: .omitted)

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour,.minute], from: dateISO ?? .distantFuture)
        return dateISO ?? .distantFuture
    }
    var SaveEndDate : Date{

        let isoDate = self.endDateAppointment

        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:isoDate)

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date ?? .today)

        return components.date ?? .now
    }
    func GetUserBareberProfile(){

        self.ref = Database.database().reference()
        guard let userIdOwner = Auth.auth().currentUser else{return}
        ref.child("User_Barber").child(userIdOwner.uid).observeSingleEvent(of: .value, with: { snapshot in

            Task {
                var dataJson =  Data()
                do{
                    let dic =  snapshot.value as? NSDictionary
                    dataJson = try JSONSerialization.data (withJSONObject: dic as Any , options: [.fragmentsAllowed])
                    let decodeData = JSONDecoder()
                    let BarberData = try decodeData.decode(UserBarberValue.self, from: dataJson)
                    self.User_barberModel = BarberData
                }catch{

                }
            }
        })
        { error in
            print(error.localizedDescription)
        }
    }
    func saveDataAppointmentToFirebase(userOwnerID:String,valueTime:String,valueTimeDuture:String){

        Auth.auth().addStateDidChangeListener { auth, user in
            print(auth,user as Any)
            if (user != nil) {
                let ref = Database.database().reference()
                let UserIDCurrent = self.User_barberModel?.childByAutoID ?? ""

                let itemsRef = ref.child("Shop_barber").child(user?.uid ?? "").child("Barber").child(UserIDCurrent)
                let post = [
                    "Appointment":[
                        "start_work":self.StartDateAppointment,
                        "End_work":self.endDateAppointment,
                        "weekend_work":self.dayOff.text,
                        "break_start":valueTime,
                        "break_end": valueTimeDuture,
                        "daysReservation": self.daysReservation,
                    ] as [String : Any],
                    "fcm": Messaging.messaging().fcmToken ?? "",
                ] as [String : Any]
                itemsRef.updateChildValues(post as [AnyHashable : Any])
            }
        }
    }
}

enum dayOffNum:Int,CaseIterable{

    case Sunday = 1
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday

    init(type: Int) {
        switch type{
        case 1:
             self = .Sunday
        case 2:
             self = .Monday
        case 3:
             self = .Tuesday
        case 4:
             self = .Wednesday
        case 5:
             self = .Thursday
        case 6:
             self = .Friday
        case 7:
             self = .Saturday
        default:
             self = .Friday
        }
    }
    func getStringDayOff() -> String{

        switch self{

        case .Sunday:
            return "Sunday"
        case .Monday:
            return "Monday"
        case .Tuesday:
            return "Tuesday"
        case .Wednesday:
            return "Wednesday"
        case .Thursday:
            return "Thursday"
        case .Friday:
            return "Friday"
        case .Saturday:
            return "Saturday"
        }
    }
    var text : String {
        switch self{

        case .Sunday:
            return "Sunday"
        case .Monday:
            return "Monday"
        case .Tuesday:
            return "Tuesday"
        case .Wednesday:
            return "Wednesday"
        case .Thursday:
            return "Thursday"
        case .Friday:
            return "Friday"
        case .Saturday:
            return "Saturday"
        }
    }
}
enum workNatureEnum:Int,CaseIterable{

    case percentage = 1
    case employee

    var text : String {
        switch self{
        case .percentage:
            return "As a percentage"
        case .employee:
            return "An employee with a monthly salary"
        }
    }
}
