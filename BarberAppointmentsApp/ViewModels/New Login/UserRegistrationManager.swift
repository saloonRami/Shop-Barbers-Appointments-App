//
//  UserRegistrationViewModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 02/09/2023.
//

import Foundation
import Combine
import Firebase
import FirebaseMessaging
import FirebaseStorage
import FirebaseAuth
import SwiftUI

final class UserRegistrationManager: ObservableObject {

    // Input
    @Published var username = ""
    @Published var password = ""
    @Published var passwordConfirm = ""
    @Published var email = ""
    @Published var PhoneNumber = ""
    @Published var ShopName = ""

    // Output
    @Published var isUsernameLengthValid = false
    @Published var isPasswordLengthValid = false
    @Published var isPasswordCapitalLetter = false
    @Published var isPasswordConfirmValid = false
    @Published var isEmailCheck = true
    @Published var isPhoneNumber = false
    @AppStorage("IsLogin") var IsLogin: Bool  = false
    @AppStorage("isShowPhoneNumber") var isShowPhoneNumber: Bool  = false

    var user: User!
    var ref: DatabaseReference!
    var imageLinces = [UIImage(named: "TonyAndGuyImage")]
    var model = [String]()

    @Published var User_Barber :  AuthDataResult? = nil

    private var cancellableSet: Set<AnyCancellable> = []

    init() {
//        self.User_Barber = AuthDataRes
        $username
            .receive(on: RunLoop.main)
            .map { username in
                return username.count >= 4
            }
            .assign(to: \.isUsernameLengthValid, on: self)
            .store(in: &cancellableSet)

        $password
            .receive(on: RunLoop.main)
            .map { password in
                return password.count >= 8
            }
            .assign(to: \.isPasswordLengthValid,on: self)
            .store(in: &cancellableSet)

        $password
            .receive(on: RunLoop.main)
            .map { password in
                let pattern = "[A-Z]"
                if let _ = password.range(of: pattern,options: .regularExpression){
                    return true
                }else {
                    return false
                }
            }
            .assign(to: \.isPasswordCapitalLetter, on: self)
            .store(in: &cancellableSet)

        Publishers.CombineLatest($password, $passwordConfirm)
            .receive(on: RunLoop.main)
            .map { (password, passwordConfirm) in
                return !passwordConfirm.isEmpty && (passwordConfirm == password)
            }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancellableSet)

        Check()
        //            createUser()
    }
    func Check(){

        $email
            .receive(on: RunLoop.main)
            .map { email in

                let pattern = "^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"
                if let _ = email.range(of: pattern, options:.regularExpression){
                    return true
                }else {
                    return false
                }

            }
            .assign(to: \.isEmailCheck,on: self)
            .store(in: &cancellableSet)

        $PhoneNumber
            .receive(on: RunLoop.main)
            .map { username in
                return username.count >= 10
            }
            .assign(to: \.isPhoneNumber, on: self)
            .store(in: &cancellableSet)

    }
    func createUser(name:String?,email_Baraber:String?,password_Baraber:String?,ShopName:String?,pathApi Path_Name: String, UserIDShop uid: String,isOwner: Bool,_ completion:@escaping(_ isSucess:Bool,AuthDataResult?) -> Void) -> Void{

    
        guard (email_Baraber != nil) && (password_Baraber != nil) else{ return }


        Auth.auth().createUser(withEmail: email_Baraber!, password: password_Baraber!) { authResult, error in

            guard error == nil else{  completion(false,nil); return}


            if (authResult?.user != nil) {
                
                let User_Barber = authResult?.user.uid
                self.ref = Database.database().reference()
                let aString = self.username.lowercased()
                _ = aString.replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)


            let itemsRef = self.ref.child(Path_Name).child(User_Barber!)
                itemsRef.setValue([
                    "name" : name ?? "",
                    "password" : password_Baraber as Any,
                    "permission":"0",
                    "IsActive" : true,
                    "phone": authResult?.user.phoneNumber as Any,
                    "IsWorking":true,
                    "isAvailable": false,
                    "isOwner": true,
                    "userID":authResult?.user.uid ?? "",
                    "Shop_id":uid,
                    "fcm" : Messaging.messaging().fcmToken as Any,
                    "ShopName": ShopName as Any,
                    "childByAutoId": itemsRef.childByAutoId().key as Any,
                    "email":authResult?.user.email as Any
                ])

                completion(true,authResult)

            }
        }
    }
    func uploadMedia(completion: @escaping (_ urls:  [String]? ) -> Void) {

        let storage = Storage.storage()
        let storageRef = storage.reference()

        let count = self.imageLinces.count
        print(count,imageLinces )


        for i in 0..<self.imageLinces.count  {



            let uploadData =  self.imageLinces[i]?.jpegData(compressionQuality: 1.0) //{
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"

            let riversRef = storageRef.child("ShopBarberPhotos/barber").child("\(generateImageName())")
            // Upload the file to the path "images/rivers.jpg"
            riversRef.putData(uploadData!, metadata: metadata) { (metadata, error) in


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
        let result = formatter.string(from: date)
        return "\(result).jepg"
    }
    
    func LoginUser(email:String,password:String) -> Bool{

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            guard (error == nil) else{
                print("\(error?.localizedDescription ?? "")")
                return
            }
            print(authResult?.user as Any)

            if ((authResult?.user.providerData.count)! > 1) {
                self?.isShowPhoneNumber = false
            }else{
                self?.isShowPhoneNumber = true
            }

            self?.IsLogin = true
        }
        return self.IsLogin
    }
    func LoginWithApple(){
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://example.appspot.com")
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setAndroidPackageName("com.firebase.example", installIfNotAvailable: false, minimumVersion: "12")

        //        let provider = FUIEmailAuth(authUI: FUIAuth.defaultAuthUI()!,
        //                                    signInMethod: FIREmailLinkAuthSignInMethod,
        //                                    forceSameDevice: false,
        //                                    allowNewEmailAccounts: true,
        //                                    actionCodeSetting: actionCodeSettings)
    }
    func GetCurrentlyUser(){
        Auth.auth().addStateDidChangeListener { auth, user in
            print(auth,user as Any)

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
    }
    func currentUser(){
        if Auth.auth().currentUser != nil {
          // User is signed in.
          // ...
        } else {
          // No user is signed in.
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

        }
    }

    func UpdatePassword(){
        Auth.auth().currentUser?.updatePassword(to: password) { error in
        }
    }

    func sendPasswordReset(){
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

