//
//  AddBarberViewModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 22/09/2023.
//

import Foundation
import Combine
import Firebase
import FirebaseDatabase
import SwiftUI

class AddBarberViewModel: ObservableObject{

    var subscriptions = Set<AnyCancellable>()
    var RegisterionVM : UserRegistrationViewModel = UserRegistrationViewModel()
    var modelDataProfile: ProfileModel?

    var Shop_barber_ModelData  : Shop_barber_InfoModel?
    @Published  var barberArry : [Barber] = []
    @Published  var barber  : Barber?
    var barberPass = PassthroughSubject<Barber,Never>()

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var ValueTextFeild: [String] = Array(repeating: "", count:  7)
    @Published var name: String = ""
    @Published var userName: String = ""
    @Published var userID: String = ""
    @Published var phoneNumber: String = "0"
    @Published var shopName: String = ""
    @Published var Locations: String = ""


    var ref: DatabaseReference!
    let userId = Auth.auth().currentUser


    init() {
        self.barber = barber
        self.barberArry = barberArry
        self.GetDataFirebaseBarber()
    }
    func UpdateDataToProperties(){
        ValueTextFeild[0] =  self.name
        ValueTextFeild[1] = self.email
        self.password = "Update Passeord"
        ValueTextFeild[2] =   self.password
        ValueTextFeild[3] = self.userID
        ValueTextFeild[4] = self.phoneNumber
        ValueTextFeild[5] =  self.shopName
        ValueTextFeild[6] =  self.Locations

        Task{
            self.modelDataProfile?.display_name = ValueTextFeild[0]
            self.modelDataProfile?.email = ValueTextFeild[1]
            self.modelDataProfile?.uid = ValueTextFeild[3]
            self.modelDataProfile?.phoneNumber = ValueTextFeild[4]
            self.modelDataProfile?.shopName = ValueTextFeild[5]
            self.modelDataProfile?.Locations = ValueTextFeild[6]
        }


    }
    func GetDataShopBarber(){

        let userID = Auth.auth().currentUser?.uid
        ManageAPI.GetDataFromFirebase("Shop_barber/Barber") { isSuccess, dataModel in

            guard ((dataModel?.isEmpty) != nil)else{ return}

            let jsonArray = dataModel?.first(where: {$0.key == userID})
            DispatchQueue.main.async {
                jsonArray
                    .publisher
                    .map({$0.value.BarberArray!})
                    .assign(to: &self.$barberArry)
            }
        }
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
    func AddBarberToDataBase(){

        self.ref = Database.database().reference()

        guard let IdShopOwner = userId?.uid else { return }
        RegisterionVM.createUser(name:ValueTextFeild[0],email_Baraber: ValueTextFeild[1], password_Baraber:  ValueTextFeild[2],ShopName:self.ValueTextFeild[5],pathApi: "User_Barber", UserIDShop: IdShopOwner,isOwner: true){ isSucess, authResult in

            if isSucess{

                guard (authResult?.user.uid) != nil else { return }
                let itemsRef = self.ref.child("Shop_barber").child(IdShopOwner).child("Barber").childByAutoId()

                itemsRef.setValue([
                                "AutoId" : itemsRef.childByAutoId().key as Any,
                                "Parent_Id" : itemsRef.childByAutoId().parent?.key as Any,
                                "root_Id" : itemsRef.childByAutoId().root.key as Any,
                                "isPersistenceEnabled_Id" : itemsRef.childByAutoId().database.isPersistenceEnabled as Any,
                                "url_AutoId" : itemsRef.childByAutoId().url ,
                                //            "access_Token": authResult?. as Any,
                                "creationDate": authResult?.user.metadata.creationDate?.string() as Any,
                                "lastSignInDate": authResult?.user.metadata.lastSignInDate?.string() as Any,
                                "profile_image" : authResult?.user.photoURL as Any ,
                                "tenantID": authResult?.user.tenantID ?? 0,
                                "providerID": authResult?.user.providerID ?? 0,
                                "refreshToken": authResult?.user.refreshToken as Any,
                                "name" : self.ValueTextFeild[0],
                                "email": authResult?.user.email as Any,
                                "isEmailVerified" : authResult?.user.isEmailVerified as Any,
                                "user_name" :self.ValueTextFeild[3],
                                "password" :self.ValueTextFeild[2],
                                "permission":"0",
                                "IsActive" : false,
                                "phone": authResult?.user.phoneNumber as Any,
                                "IsWorking":true,
                                "isAvailable": true,
                                "isOwner": false,
                                "userID_barber":authResult?.user.uid ?? "",
                                "userID_owner" : IdShopOwner ,
                                "Shop_id":IdShopOwner,
                                "fcm" : Messaging.messaging().fcmToken as Any,
                                "ShopName": self.ValueTextFeild[5],
                                "uuid":UUID().uuidString,
                                "Location_shop": [
                                    "latitude":34.011286,
                                    "longitude":-116.166868
                                    ]
                ])

                // send VerificationEmail
                self.UpdateDataToProperties()
                self.UpdateUserProfile()
                self.RegisterionVM.SetUserEmailAddress(email: self.email)
                self.RegisterionVM.UpdatePassword()
                self.RegisterionVM.SendUserVerificationEmail()
            }
        }
    }
    func UpdateUserProfile(){

        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = ValueTextFeild[0]

        changeRequest?.commitChanges { error in
          // ...
            print(changeRequest?.displayName as Any)
            print(changeRequest?.photoURL as Any)
        }
    }

    func createUserBarber(email:String,password:String,_ completion:@escaping(_ isSucess:Bool,AuthDataResult?) -> Void){

        Auth.auth().createUser(withEmail: email, password: password){ authResult, error in
            print(authResult as Any,error as Any)

            guard error != nil else{  completion(false,nil); return}
            if (authResult?.user != nil) {
                completion(true,authResult)
            }
        }
    }
    func GetBarberShop(){

        let userID = Auth.auth().currentUser?.uid
        let firebase = FirebaseConnection(baseURL: Constants.BaseURL)
        firebase.auth =  Constants.Database_SecretKey
        firebase.get(path: "Shop_barber") { data in

           data.publisher
                .map{data in return self.$barber.map({_ in data })}
//                .assign(to: \.valueType, on: self.barberPass)

                .sink { data in
                    print(data)
                    print(self.barberPass)
                }
                .store(in: &self.subscriptions)

        }
        self.barberPass
            .sink { val in
            print(val)
        }
        .store(in: &self.subscriptions)

//         self.barberPass.send(completion: .finished)
    }

    func didTapSendSignInLink( emailField: String?) {
        if let email = emailField {
//            showSpinner {
                // [START action_code_settings]
                let actionCodeSettings = ActionCodeSettings()
                actionCodeSettings.url = URL(string: "https://barbershops.page.link")
                // The sign-in operation has to always be completed in the app.
                actionCodeSettings.handleCodeInApp = true
                actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
                actionCodeSettings.setAndroidPackageName("com.example.android",
                                                         installIfNotAvailable: false, minimumVersion: "12")
                // [END action_code_settings]
                // [START send_signin_link]
                Auth.auth().sendSignInLink(toEmail: email,
                                           actionCodeSettings: actionCodeSettings) { error in
                    // [START_EXCLUDE]
//                    self.hideSpinner {
                        // [END_EXCLUDE]
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        // The link was successfully sent. Inform the user.
                        // Save the email locally so you don't need to ask the user for it again
                        // if they open the link on the same device.
                        UserDefaults.standard.set(email, forKey: "Email")
                        print("Check your email for link")
                        // [START_EXCLUDE]
//                    }
                    // [END_EXCLUDE]
                }
                // [END send_signin_link]
//            }
        } else {
            print("Email can't be empty")
        }
    }
}
