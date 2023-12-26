//
//  StaffManagementViewModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 04/10/2023.
//

import Foundation
import Combine
import FirebaseMessaging
import FirebaseAuth
import Firebase
class StaffManagementViewModel:ObservableObject{


    @Published var barberModel : [Barber] = []
    @Published var ShopInfoModel : ShopInfo?

    var ref: DatabaseReference!
    let userId = Auth.auth().currentUser

    init() {
        GetBarbersFromShop_barber()
        GetShop_infoFromShop_barber()
    }

     func GetBarbersFromShop_barber(){

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
                     self.barberModel = BarberData
                 }catch{
                 }
             }
         })
         { error in
             print(error.localizedDescription)
         }
    }
    func GetShop_infoFromShop_barber(){

        self.ref = Database.database().reference()
        guard let userIdOwner = Auth.auth().currentUser?.uid else { return  }
        ref.child("Shop_barber").child(userIdOwner).child("Shop_info").observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.childrenCount != 0 else{return}
            Task {
                var dataJson =  Data()
                do{
                    let dic =  snapshot.value as! NSDictionary
                    dataJson = try JSONSerialization.data (withJSONObject: dic as Any  , options: [.fragmentsAllowed])
                    let decodeData = JSONDecoder()
                    let shopInfoData = try decodeData.decode(ShopInfo.self, from: dataJson)
                    self.ShopInfoModel = shopInfoData
                }catch{

                }
            }
        })
        { error in
            print(error.localizedDescription)
        }
   }
}
