//
//  LoginEmailViewModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 02/11/2023.
//
//
//  LoginEmailViewModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 02/11/2023.
//


import Foundation
import Combine
import Firebase
import FirebaseAuth
import SwiftUI
import GoogleSignIn

class LoginEmailViewModel:ObservableObject {

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
    @Published var IsFirstIndexPhoneZero: Bool = false
    @Published var IsVerfiyPhoneNumber: Bool = false

    @Published var CurrrentUser: User? = nil
    @Published var IsEmailExesit : Bool = false
    var link: String!

    var GetSwitch: SwitchCheckEmail?
    let workoutDateRange = Date()...Date().addingTimeInterval(4)
    var ViewTap : AnyView?

    private var cancellableSet: Set<AnyCancellable> = []

    @AppStorage("IsLogin") var IsLogin: Bool  = false
    @AppStorage("isShowPhoneNumber") var isShowPhoneNumber: Bool  = false


    init() {
        self.CurrrentUser = Auth.auth().currentUser
        Check()
//        $password
//            .receive(on: RunLoop.main)
//            .map { password in
//                return password.count >= 8
//            }
//            .assign(to: \.isPasswordLengthValid,on: self)
//            .store(in: &cancellableSet)
//
//        $password
//            .receive(on: RunLoop.main)
//            .map { password in
//                let pattern = "[A-Z]"
//                if let _ = password.range(of: pattern,options: .regularExpression){
//                    return true
//                }else {
//                    return false
//                }
//            }
//            .assign(to: \.isPasswordCapitalLetter, on: self)
//            .store(in: &cancellableSet)


//        Publishers.CombineLatest($password, $passwordConfirm)
//            .receive(on: RunLoop.main)
//            .map { (password, passwordConfirm) in
//                return !passwordConfirm.isEmpty && (passwordConfirm == password)
//            }
//            .assign(to: \.isPasswordConfirmValid, on: self)
//            .store(in: &cancellableSet)

    }

    func ChechEmailExesit(Email: String){

        Logout()
        print( Auth.auth().currentUser?.providerData as Any)
        Auth.auth().fetchSignInMethods(forEmail: Email){ data,error in
            print(Email as Any,data as Any,error?.localizedDescription as Any)

            self.IsEmailExesit = true

            guard data != nil else{
                self.GetSwitch = SwitchCheckEmail(rawValue: data?.description ?? "nil") ?? .NotExist
                self.ViewTap = (self.GetSwitch?.GetSwitch(email: Email))
                return
            }

            self.GetSwitch = SwitchCheckEmail(rawValue: data?.first?.description ?? "password") ?? .password
            self.ViewTap =  (self.GetSwitch?.GetSwitch(email: Email))

        }
    }
    func GoogleSign(){

        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
//        GIDSignIn.sharedInstance.signIn(withPresenting: EmailCheckAndFetchView(Vm: LoginEmailViewModel()).self) { [unowned self] result, error in
//          guard error == nil else {
//            // ...
//          }
//
//          guard let user = result?.user,
//            let idToken = user.idToken?.tokenString
//          else {
//            // ...
//          }
//
//          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
//                                                         accessToken: user.accessToken.tokenString)
//
//          // ...
//        }

    }
    func LoginWithPassword(email:String,Password: String) -> Bool{

        Auth.auth().signIn(withEmail: email, password: Password) { [weak self] authResult, error in
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
    func didTapSendSignInLink() {

        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://haircut.page.link/jdF1")
        // The sign-in operation has to always be completed in the app.
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        actionCodeSettings.setAndroidPackageName("BarberShops.Appoiment.SaloonApps.android",
                                                 installIfNotAvailable: false, minimumVersion: "12")

        Auth.auth().sendSignInLink(toEmail:"hightik.app@gmail.com",
                                   actionCodeSettings: actionCodeSettings) { error in
          // ...
            if let error = error {
              print(error.localizedDescription)
              return
            }
            // The link was successfully sent. Inform the user.
            // Save the email locally so you don't need to ask the user for it again
            // if they open the link on the same device.
            UserDefaults.standard.set(self.email, forKey: "Email")
            print("Check your email for link")
            // ...
        }
    }
    func didTapSignInWithEmailLink(emails:String,emailLink:String) {

//          showSpinner {
            // [START signin_emaillink]
            Auth.auth().signIn(withEmail: emails, link: self.link) { user, error in
              // [START_EXCLUDE]
                if let error = error {
//                  showMessagePrompt(error.localizedDescription)
                    print(error.localizedDescription)
                  return
                }
                else {
//                 showMessagePrompt("Email can't be empty")
                    print(user as Any)
               }
//                navigationController!.popViewController(animated: true)
              // [END_EXCLUDE]
            }
            // [END signin_emaillink]
//          }
//        }
      }


    func Logout(){

        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.IsEmailExesit = false
        } catch let signOutError as NSError {
         return print("Error signing out: %@", signOutError)
        }
    }
}
extension LoginEmailViewModel{

func Check(){
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

//    Publishers.CombineLatest($password, $passwordConfirm)
//        .receive(on: RunLoop.main)
//        .map { (password, passwordConfirm) in
//            return !passwordConfirm.isEmpty && (passwordConfirm == password)
//        }
//        .assign(to: \.isPasswordConfirmValid, on: self)
//        .store(in: &cancellableSet)

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

//    $PhoneNumber
//        .receive(on: RunLoop.main)
//        .map { phone in
//            return phone.count >= 10
//        }
//        .assign(to: \.isPhoneNumber, on: self)
//        .store(in: &cancellableSet)

    $PhoneNumber
           .receive(on: RunLoop.main)
           .map { phone in

             let d = phone.contains { Character in
                   Character.description.first == "0"
               }
               return self.PhoneNumber.count >= 9 && d == false
           }
           .assign(to: \.IsVerfiyPhoneNumber, on: self)
           .store(in: &cancellableSet)

        $PhoneNumber
            .receive(on: RunLoop.main)
            .map { username in
                return  username.contains { Character in
                    Character.description.first == "0"
                }
            }
            .assign(to: \.IsFirstIndexPhoneZero, on: self)
            .store(in: &cancellableSet)

}
}
