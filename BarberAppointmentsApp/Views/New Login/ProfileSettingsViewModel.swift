//
//  ProfileSettingsViewModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 21/09/2023.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth
import FirebaseStorage
import UIKit
class ProfileSettingsViewModel:ObservableObject{

//    @Published var name: ProfileNum = ProfileNum.AllCases.Type
    @Published var modelDataProfile: ProfileModel?
    @Published var User_barberModel: UserBarberValue?

    @Published var email: String = ""
    @Published var userID: String = ""
    @Published var password : String = ""
    @Published var display_name : String = ""
    @Published var MobileNum : String = ""
    @Published var shopName : String = ""
    @Published var Locations : String = ""
    @Published var providerID : String = ""
    @Published var refreshToken : String = ""
    @Published var dateOfbrith : String = ""
    @Published var gender : String = ""
    @Published var photoURL: URL? = nil
    @Published var enterValue : String = ""
    @Published var enterValue2 : [ProfileNum.RawValue:String] = [:]
    @Published var ValueTextFeild: [String] = Array(repeating: "", count:  infoCustomer.StoreOwenerCustomer.count)


    var imageLinces = [UIImage(named: "TonyAndGuyImage")]
    var model = [String]()

    var ref: DatabaseReference!
    let userId = Auth.auth().currentUser

    init() {
//        self.photoURL = photoURL
        self.GetUserProfile()
    }

    func UpdateDataToProperties(){
        ValueTextFeild[0] =  self.display_name
        ValueTextFeild[1] = self.email
        self.password = "Update Passeord"
        ValueTextFeild[2] =   self.password
        ValueTextFeild[3] = self.userID
        ValueTextFeild[4] = self.MobileNum
        ValueTextFeild[5] =  self.shopName
        ValueTextFeild[6] =  self.Locations
//        self.photoURL = self.photoURL?.absoluteString ?? ""

        self.modelDataProfile?.display_name = ValueTextFeild[0]
        self.modelDataProfile?.email = ValueTextFeild[1]
        self.modelDataProfile?.uid = ValueTextFeild[3]
        self.modelDataProfile?.phoneNumber = ValueTextFeild[4]
        self.modelDataProfile?.shopName = ValueTextFeild[5]
        self.modelDataProfile?.Locations = ValueTextFeild[6]


    }
    
    func GetNameFromEnum(enterValueNum: String) -> String{

        let user = Auth.auth().currentUser

        if let user = user {
            switch ProfileNum(rawValue: enterValueNum){
            case .UserID:
                return  user.uid
            case .some(.Name):
                return user.displayName ?? ""
            case .photoURL :
                return  user.photoURL?.absoluteString ?? ""
            case .Email:
                return user.email ?? ""
            case .MobileNum:
                return user.phoneNumber ?? ""
            case .dateOfbrith:
                return user.providerData.description
            case .Gender:
                return user.providerID
            case .none:
                return ""
            case .some(.password):
                return user.providerData.first.debugDescription
            case .some(.shopNamw):
                return ""
            case .some(.Locations):
               return ""
            }
        }
        return "Wrong Data"
    }
    func GetFuncProfileForUpdate(num:String,TextFieldValue:String){
        switch ProfileNum(rawValue: num){

        case .password:
            self.UpdatePassword(password: TextFieldValue)
        case .Name:
            self.UpdateUserProfile(TextFieldValue)
        case .Email:
            self.SetUserEmailAddress(email: TextFieldValue)
        case .none:
            break
        case .some(.UserID):
            break
        case .some(.photoURL):
            self.photoURL =  photoURL?.absoluteURL
        case .some(.MobileNum):
            break
        case .some(.dateOfbrith):
            break
        case .some(.Gender):
            break
        case .some(.shopNamw):
            break
        case .some(.Locations):
            break
        }
    }
    func GetUserProfile(){
        self.UpdateDataToProperties()
        let user = Auth.auth()
        if  let users = user.currentUser {
          // The user's ID, unique to the Firebase project.
          // Do NOT use this value to authenticate with your backend server,
          // if you have one. Use getTokenWithCompletion:completion: instead.

            self.userID = user.currentUser!.uid
            self.email = user.currentUser?.email ?? ""
            self.display_name =  user.currentUser?.displayName ?? ""
            self.MobileNum =  user.currentUser?.phoneNumber ?? ""
            self.providerID =  user.currentUser!.providerID
            self.refreshToken =  user.currentUser?.refreshToken ?? ""
            guard user.currentUser?.photoURL != nil else{ return}
            self.photoURL =  user.currentUser?.photoURL?.absoluteURL
//            self.tenantID = user.tenantID
//            self.providerData = user.providerData
//            self.multiFactor = user.multiFactor
//            self.metadata = user.metadata


            self.modelDataProfile?.uid =  user.currentUser?.uid ?? ""
            self.modelDataProfile?.email =  user.currentUser?.email ?? ""
            self.modelDataProfile?.display_name =  user.currentUser?.displayName ?? ""
            self.modelDataProfile?.phoneNumber =  user.currentUser?.phoneNumber ?? ""
            self.modelDataProfile?.providerID =  user.currentUser!.providerID
            self.modelDataProfile?.refreshToken =  user.currentUser!.refreshToken
            self.modelDataProfile?.tenantID =  user.currentUser!.tenantID
            self.modelDataProfile?.providerData =  user.currentUser!.providerData
            self.modelDataProfile?.multiFactor =  user.currentUser!.multiFactor
            self.modelDataProfile?.metadata =  user.currentUser!.metadata


            if  user.currentUser?.photoURL != nil{
                self.modelDataProfile?.photoURL =  (user.currentUser?.photoURL)!
                self.photoURL =  user.currentUser?.photoURL
            }
          var multiFactorString = "MultiFactor: "
            for info in  user.currentUser!.multiFactor.enrolledFactors {
            multiFactorString += info.displayName ?? "[DispayName]"
            multiFactorString += "gender"
          }
//           ...
        }
    }
    func UpdateImageProfile(_ url:String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = URL(string: url)
        changeRequest?.commitChanges { error in
          // ...
            self.GetUserProfile()
            print(error as Any)
        }
    }
    func UpdateUserProfile(_ displayName:String){

        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
//        changeRequest?.photoURL = photoURL
        changeRequest?.commitChanges { error in
          // ...
            self.GetUserProfile()
            print(error as Any)
        }
    }
    func SetUserEmailAddress(email:String){

        Auth.auth().currentUser?.updateEmail(to: email) { error in
         // ...
            self.GetUserProfile()
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

    func UpdatePassword(password:String){
        Auth.auth().currentUser?.updatePassword(to: password) { error in
            self.GetUserProfile()
        }
    }

    func sendPasswordReset(email:String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in

        }
    }
    func Logout(){

        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
         return print("Error signing out: %@", signOutError)
        }
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
    func uploadMedia(image: UIImage,_ completion: @escaping (_ urls:  [String]? ) -> Void) -> Void {

        let storage = Storage.storage()
        let storageRef = storage.reference()

        let count = self.imageLinces.count
        print(count,imageLinces )


        for i in 0..<self.imageLinces.count  {



            let uploadData =  self.imageLinces[i]?.jpegData(compressionQuality: 1.0) //{
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"

            let riversRef = storageRef.child("ShopBarberPhotos/barberImage/\("ProfileImage")").child("\(generateImageName())")
            // Upload the file to the path "images/rivers.jpg"
           riversRef.putData(image.pngData()!, metadata: metadata) { (metadata, error) in


                // Add a progress observer to an upload task
//              let observer = d.observe(.progress) { snapshot in
//                  // A progress event occured
//                }

               guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                }

                // Metadata contains file metadata such as size, content-type.
                _ = metadata.size

                // You can also access to download URL after upload.
                riversRef.downloadURL { (url, error) in
                    if error != nil {
                        // Handle any errors
                    } else {
                        // Get the download URL for 'images/stars.jpg'
                        let lineCutter = url?.absoluteString ?? "null"
//                        let positionToInsertAt = i
                        // self.model.append(lineCutter)
                        self.model += [lineCutter]
                        self.UpdateImageProfile(lineCutter)
                        completion(self.model)

                        // print(url as Any,self.model[i] )

                        return
                    }


                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    print(downloadURL)
                }


            }

        }
    }
    func generateImageName() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmSS"
//        let result = formatter.string(from: date)
       let ImageName = self.userID
        return "\(ImageName).jepg"
    }
}
