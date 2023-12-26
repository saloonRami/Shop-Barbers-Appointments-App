//
//  ManageAPI.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/09/2023.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseMessaging
import Firebase
import Combine

class ManageAPI{

    class func GetUser(){

        let firebase = FirebaseConnection(baseURL: Constants.BaseURL)
        firebase.auth = Constants.Database_SecretKey

        // sync
        let user = firebase.get(path: "users")
        print(user as Any)

    }

    class func GetDataFromFirebase(_ PathApiString:String,_ completion:@escaping(_ isSuccess:Bool,Shop_barber_InfoModel?) -> Void){
        
        var dataJson =  Data()
        var dataJsonBarber = Data()
        let userID = Auth.auth().currentUser?.uid
        let firebase = FirebaseConnection(baseURL: Constants.BaseURL)
//        firebase.auth =  Constants.Database_SecretKey
//        firebase.accessToken = Messaging.messaging().fcmToken?.description
        firebase.get(path: PathApiString) { data in
            guard  data != nil else{return}
            do{
                let decodeData = JSONDecoder()
                dataJson = try JSONSerialization.data (withJSONObject: data as! NSDictionary, options: [])
              let dat = try decodeData.decode([Barber].self, from: dataJson)
//                let first =   dat.first(where: {$0.userID == userID})
                completion(true,nil)
//                completion(true,json?.value.barber)
//                print(dat.first(where: { $0.key == userID }) as Any)
            }catch{
                print(dataJson as Any)
                completion(false,nil)
            }
        }
    }
   
    class func CreateBarberShop(){
        var dataJson =  Data()
        let userID = Auth.auth().currentUser?.uid
        let firebase = FirebaseConnection(baseURL: Constants.BaseURL)

    }
    class func GetCurrentShopOwner() -> Bool{
        Auth.auth().addStateDidChangeListener { auth, user in
            print(auth,user as Any)

            for i in 0...(user?.providerData.count)!{

                guard user?.providerData[i].phoneNumber != nil else {
                   return
                }
            }
            if (user != nil) {

                let ref = Database.database().reference()
                let aString = user?.uid

                let itemsRef = ref.child("Shop_barber").child((aString)!).child("Shop_info")
                let post = [
                    "fcm": Messaging.messaging().fcmToken,
                ]
                itemsRef.updateChildValues(post as [AnyHashable : Any])
            }
        }
        return false
    }
  class func GetCurrentlyUser(){
      
        Auth.auth().addStateDidChangeListener { auth, user in
            print(auth,user as Any)
            if  user?.email != nil{
//                self?.loadingIndicator()
                let ref = Database.database().reference()
                let aString = user?.email?.lowercased() ?? ""
                    let newString = aString.replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
                    let itemsRef = ref.child("users").child(newString.lowercased())
//                itemsRef.setValue([
//
//                   "profile_image" : "person.circle.fill",
//                   "name" : self.NameTextFeild.text!,
//                   "password" : self.PasswordTextFeild.text!,
//                   "permission":"0",
//                   "phone": self.PhoneNumberTextFeild.text!,
//                   "status":"1",
//                   "fcm":Messaging.messaging().fcmToken,
//                   "country": self.CountryTextFeild.text!,
//                   "email": self.UserNameTextFeild.text?.lowercased()
//               ])
                let post = [
                    "fcm": Messaging.messaging().fcmToken,
                         ]
                itemsRef.updateChildValues(post as [AnyHashable : Any])
            }
            if user?.email != nil {

//             let alert = UIAlertController(title: "", message: error?.localizedDescription , preferredStyle: UIAlertController.Style.alert)
//             alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                self?.present(alert, animated: true, completion: nil)
          }
        }
    }

}
