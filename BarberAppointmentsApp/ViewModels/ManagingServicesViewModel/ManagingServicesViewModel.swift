//
//  ManagingServicesViewModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 19/10/2023.
//

import Foundation
import Combine
import Firebase

class ManagingServicesViewModel:ObservableObject{

    @Published var TimesServices : String = ""
    @Published var PriceServices : String = ""
    @Published  var barberArry : [Barber]?

    var ref: DatabaseReference!

    init(){
//        AddServiceToDataBase()
    }
    
    func GetDataFirebaseBarber(){

        self.ref = Database.database().reference()
        guard let userIdOwner = Auth.auth().currentUser?.uid else { return  }
        ref.child("Shop_barber").child(userIdOwner).child("Barber").observeSingleEvent(of: .value, with: { snapshot in

            Task {
                var dataJson =  Data()
                do{
                    let dic =  snapshot.value as? NSDictionary
                    dataJson = try JSONSerialization.data (withJSONObject: dic?.allValues as Any , options: [.fragmentsAllowed])
                    let decodeData = JSONDecoder()
                    let BarberData = try decodeData.decode([Barber].self, from: dataJson)
                    self.barberArry = BarberData
                }catch{
                }
            }
        })
        { error in
            print(error.localizedDescription)
        }
    }
//    func AddServiceToDataBase(){
//
//        Auth.auth().addStateDidChangeListener { auth, user in
//            print(auth,user as Any)
//            if (user != nil) {
//                let ref = Database.database().reference()
//                let UserIDCurrent = self.User_barberModel?.childByAutoID ?? ""
//
//                let itemsRef = ref.child("Shop_barber").child(userOwnerID).child("Barber").child(UserIDCurrent)
//                let post = [
//                    "Appointment":[
//                        "start_work":self.StartDateAppointment,
//                        "End_work":self.endDateAppointment,
//                        "weekend_work":self.dayOff.text,
//                        "break_start":valueTime,
//                        "break_end": valueTimeDuture,
//                    ] as [String : Any],
//                    "fcm": Messaging.messaging().fcmToken ?? "",
//                ] as [String : Any]
//                itemsRef.updateChildValues(post as [AnyHashable : Any])
//            }
//        }
//    }
}
