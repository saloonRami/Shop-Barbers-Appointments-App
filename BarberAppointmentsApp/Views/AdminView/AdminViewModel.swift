//
//  AdminViewModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 21/09/2023.
//

import Foundation
import Combine
import Firebase
//import FirebaseAuth
//import FirebaseMessaging
//import FirebaseDatabase

class AdminViewModel:ObservableObject{

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var ValueTextFeild: [String] = Array(repeating: "", count:  7)
    @Published var name: String = ""
    @Published var userName: String = ""
    @Published var phoneNumber: String = "0"
    @Published var shopName: String = ""
    @Published var Locations: String = ""
    @Published var isOWnerBarber: Bool = true
    var ref: DatabaseReference!

    init() {
    }
    func UpdateDataToProperties(){
        self.name = ValueTextFeild[0]
        self.email = ValueTextFeild[1]
        self.password = ValueTextFeild[2]
        self.userName = ValueTextFeild[3]
        self.phoneNumber = ValueTextFeild[4]
        self.shopName = ValueTextFeild[5]
        self.Locations = ValueTextFeild[6]
    }

    func createUserBarber(email:String,password:String,_ completion:@escaping(_ isSucess:Bool,Any?) -> Void){

        Auth.auth().createUser(withEmail: email, password: password){ authResult, error in
            print(authResult as Any,error as Any)

            guard error != nil else{  completion(false,nil); return}
            if (authResult?.user != nil) {
                completion(true,authResult as Any)
            }
        }
    }

    func createUser(){
        UpdateDataToProperties()


        Auth.auth().addStateDidChangeListener { authResult, user in
//            print(authResult.currentUser,user as Any)
            self.UpdateUserProfile(self.name)

            if (authResult.currentUser != nil) {
            self.ref = Database.database().reference()
                let Userid = user?.uid

            //                if let newString = authResult?.user.email?.lowercased().replacingOccurrences(of: ".", with: ",", options: .literal, range: nil){
            //                    let itemsRef = self.ref.child("users").child((newString?.lowercased())!)
            //                }else{
            //
            //                }
            // self.uploadMedia { (url) in
            //                if url != nil{


                let itemsRef = self.ref.child("Shop_barber").child((Userid)!).child("Shop_info")
                itemsRef.setValue([
                    "childByAutoId" : itemsRef.childByAutoId().key as Any,
                    //                    "access_Token": authResult?.user.providerData.first. as Any,
                    "creationDate": authResult.currentUser?.metadata.creationDate?.string() as Any,
                    "lastSignInDate": authResult.currentUser?.metadata.lastSignInDate?.string() as Any,
                    "profile_image" :authResult.currentUser?.photoURL as Any ,
                    "tenantID": authResult.currentUser?.tenantID ?? 0,
                    "providerID": authResult.currentUser?.providerID ?? 0,
                    "refreshToken": authResult.currentUser?.refreshToken as Any,
                    "uuid":UUID().uuidString,
                    "userID" : Userid ?? "",
                    "name" : self.name,
                    "user_name" : self.userName,
                    "password" : self.password,
                    "permission":"0",
                    "phone": authResult.currentUser?.providerData.first?.phoneNumber as Any,
                    "status": true,
                    "fcm" : Messaging.messaging().fcmToken as Any,
                    "ShopName": self.shopName,
                    "email": self.email.lowercased(),
                    "Location_shop": ["latitude":34.011286,
                                      "longitude":-116.166868
                                     ]
                ])
                if self.isOWnerBarber == true{

//                    guard let BarberUserID = itemsRef.childByAutoId().key else { return }
                    let itemsRef = self.ref.child("Shop_barber").child(Userid!).child("Barber").childByAutoId()

                    itemsRef.setValue([
                        "AutoId" : itemsRef.childByAutoId().key as Any,
                        "Parent_Id" : itemsRef.childByAutoId().parent?.key as Any,
                        "root_Id" : itemsRef.childByAutoId().root.key as Any,
                        "isPersistenceEnabled_Id" : itemsRef.childByAutoId().database.isPersistenceEnabled as Any,
                        "url_AutoId" : itemsRef.childByAutoId().url ,
                        //            "access_Token": authResult?. as Any,
                        "creationDate": user?.metadata.creationDate?.string() as Any,
                        "lastSignInDate": user?.metadata.lastSignInDate?.string() as Any,
                        "profile_image" : user?.photoURL as Any ,
                        "tenantID": user?.tenantID ?? 0,
                        "providerID": user?.providerID ?? 0,
                        "refreshToken":user?.refreshToken as Any,
                        "name" : self.ValueTextFeild[0],
                        "email":  self.ValueTextFeild[1] as Any,
                        "isEmailVerified" : user?.isEmailVerified as Any,
                        "user_name" :self.ValueTextFeild[3],
                        "password" :self.ValueTextFeild[2],
                        "permission":"0",
                        "IsActive" : false,
                        "phone": user?.phoneNumber as Any,
                        "IsWorking":true,
                        "isAvailable": true,
                        "isOwner": true,
                        "userID_barber":user?.uid ?? "",
                        "userID_owner" : Userid as Any ,
                        "Shop_id":Userid as Any,
                        "fcm" : Messaging.messaging().fcmToken as Any,
                        "ShopName": self.ValueTextFeild[5],
                        "uuid":UUID().uuidString,
                        "Location_shop": [
                            "latitude":34.011286,
                            "longitude":-116.166868
                        ]
                    ])
                    let itemsRef2 = self.ref.child("User_Barber").child(Userid!)
                    itemsRef2.setValue([
                        "name" : self.name ,
                        "password" : self.ValueTextFeild[2] as Any,
                        "permission":"0",
                        "IsActive" : true,
                        "phone": user?.phoneNumber as Any,
                        "IsWorking":true,
                        "isAvailable": false,
                        "isOwner": true,
                        "userID":user?.uid ?? "",
                        "Shop_id":Userid as Any ,
                        "fcm" : Messaging.messaging().fcmToken as Any,
                        "ShopName": self.ValueTextFeild[5] as Any,
                        "childByAutoId": itemsRef2.childByAutoId().key as Any,
                        "email": self.ValueTextFeild[1]
                    ])

                }

                // send VerificationEmail
                self.UpdateDataToProperties()
                self.UpdateUserProfile(self.name)
                self.SetUserEmailAddress(email: self.email)
                _ =  self.UpdatePassword(email: self.email, password: self.password)
                self.SendUserVerificationEmail()
            }
        }
    }
    func GetCurrentlyUser(){
        Auth.auth().addStateDidChangeListener { auth, user in
            print(auth,user as Any)

            if (user != nil) {
                self.ref = Database.database().reference()
                let aString = user?.uid

                let itemsRef = self.ref.child("Shop_barber").child((aString)!).child("Shop_info")
                let post = [
                    "fcm": Messaging.messaging().fcmToken,
                ]
                itemsRef.updateChildValues(post as [AnyHashable : Any])
            }
        }
    }
    func UpdateUserProfile(_ displayName:String){

        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        changeRequest?.commitChanges { error in
          // ...
        }
    }
    func SetUserEmailAddress(email: String){

       Auth.auth().currentUser?.updateEmail(to: email) { error in

           print(email,error != nil)
         // ...
       }
    }
    func SendUserVerificationEmail(){
        Auth.auth().currentUser?.sendEmailVerification { error in
            guard error == nil else {
                return
            }
            print(error as Any)
        }
    }

    func UpdatePassword(email: String,password: String) -> Bool{

        Auth.auth().currentUser?.updatePassword(to: self.password) { error in

            guard error == nil else {
                return
            }
            print(error as Any)
        }
        return true
    }

    func sendPasswordReset(email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in

        }
    }

    func deleteUser(){
        let user = Auth.auth().currentUser

        user?.delete { error in
            if error != nil {
                // An error happened.
            } else {
                // Account deleted.
            }
        }
    }
}

