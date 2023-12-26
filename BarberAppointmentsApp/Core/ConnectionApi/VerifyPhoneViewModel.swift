//
//  VerifyPhoneViewModel.swift
//  CostumrSaloonApp
//
//  Created by Rami Alaidy on 12/09/2023.
//

import Foundation
import SwiftUI
import Combine
import FirebaseAuth
import Firebase
import GoogleSignIn
import CryptoKit
import AuthenticationServices
final class VerifyPhoneViewModel:ObservableObject{

    @Published var PhoneNumber: String = ""
    @Published var IsVerfiyCode: Bool = false
    @Published var IsVerfiyPhoneNumber: Bool = false
    @Published var OTPVerfiyCode : [String]
    @Published var IsFirstIndexPhoneZero: Bool = false
    // Personal Information

    // Input
    @Published var name = ""
    @Published var password = ""
    @Published var passwordConfirm = ""
    @Published var email = ""
    @Published var UserId = ""
    @Published var Uid = ""
    @Published var ProviderID = ""
    // Output
    @Published var isUsernameLengthValid = false
    @Published var isPasswordLengthValid = false
    @Published var isPasswordCapitalLetter = false
    @Published var isPasswordConfirmValid = false
    @Published var isEmailCheck = false
    @Published var isPhoneNumber = false

    @AppStorage("isShowPhoneNumber") var isShowPhoneNumber: Bool  = false
    @AppStorage("IsLogin") var IsLogin: Bool  = false

    private var cancellableSet: Set<AnyCancellable> = []

    init(OTPVerfiyCode: [String]? = nil) {
        self.OTPVerfiyCode = OTPVerfiyCode ?? []

        let reduse = self.OTPVerfiyCode.reduce("") { partialResult, data in
            partialResult + data
        }
        print(OTPVerfiyCode as Any,reduse)

        initRequerments()

        let settings = Firestore.firestore().settings
        settings.host = "127.0.0.1:8080"
        settings.isPersistenceEnabled = false
        settings.isSSLEnabled = false
        Firestore.firestore().settings = settings
    }


    func VerifyPhoneNumber(){

        print(self.PhoneNumber)
        let phone = "+962" + PhoneNumber
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phone, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    // self.showMessagePrompt(error.localizedDescription)
                    print(error.localizedDescription)
                    return
                }

                // Sign in using the verificationID and the code sent to the user
                // ...
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                print(self.PhoneNumber,verificationID as Any)

                guard verificationID != nil else{return}
//                self.SigninWithVerificationCode(self.OTPVerfiyCode)
                 self.IsVerfiyPhoneNumber.toggle()
            }
    }

    func initRequerments(){

        $PhoneNumber
               .receive(on: RunLoop.main)
               .map { username in

                 let d =   username.contains { Character in
                       Character.description.first == "0"
                   }
                   return username.count >= 9 && d == false
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
    func SigninWithVerificationCode(_ verificationCode:String){

        Task(priority: .background) {

            if let verificationID = UserDefaults.standard.string(forKey: "authVerificationID"){

                let credential = PhoneAuthProvider.provider().credential(
                    withVerificationID: verificationID,
                    verificationCode: verificationCode
                )
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        print(error.localizedDescription)
                        let authError = error as NSError
                        if  authError.code == AuthErrorCode.secondFactorRequired.rawValue {
                            // The user is a multi-factor user. Second factor challenge is required.
                            let resolver = authError
                                .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
                            var displayNameString = ""
                            for tmpFactorInfo in resolver.hints {
                                displayNameString += tmpFactorInfo.displayName ?? ""
                                displayNameString += " "
                            }

                            //                        self.showTextInputPrompt(
                            //                            withMessage: "Select factor to sign in\n\(displayNameString)",
                            //                            completionBlock: { userPressedOK, displayName in
                            //                                var selectedHint: PhoneMultiFactorInfo?
                            //                                for tmpFactorInfo in resolver.hints {
                            //                                    if displayName == tmpFactorInfo.displayName {
                            //                                        selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
                            //                                    }
                            //                                }
                            //                                PhoneAuthProvider.provider()
                            //                                    .verifyPhoneNumber(with: selectedHint!, uiDelegate: nil,
                            //                                                       multiFactorSession: resolver
                            //                                        .session) { verificationID, error in
                            //                                            if error != nil {
                            //                                                print(
                            //                                                    "Multi factor start sign in failed. Error: \(error.debugDescription)"
                            //                                                )
                            //                                            } else {
                            //                                                self.showTextInputPrompt(
                            //                                                    withMessage: "Verification code for \(selectedHint?.displayName ?? "")",
                            //                                                    completionBlock: { userPressedOK, verificationCode in
                            //                                                        let credential: PhoneAuthCredential? = PhoneAuthProvider.provider()
                            //                                                            .credential(withVerificationID: verificationID!,
                            //                                                                        verificationCode: verificationCode!)
                            //                                                        let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator
                            //                                                            .assertion(with: credential!)
                            //                                                        resolver.resolveSignIn(with: assertion!) { authResult, error in
                            //                                                            if error != nil {
                            //                                                                print(
                            //                                                                    "Multi factor finanlize sign in failed. Error: \(error.debugDescription)"
                            //                                                                )
                            //                                                            } else {
                            //                                                                self.navigationController?.popViewController(animated: true)
                            //                                                            }
                            //                                                        }
                            //                                                    }
                            //                                                )
                            //                                            }
                            //                                        }
                            //                            }
                            //                        )
                        } else {
                            print(error.localizedDescription)
                            return
                        }
                        // ...
                        return
                    }
                    self.IsVerfiyCode.toggle()
                    // User is signed in
                    // ...
                    print(authResult?.user.refreshToken as Any)
                    print(authResult?.credential as Any)
                    print(authResult?.user.debugDescription as Any)
                    print(authResult?.additionalUserInfo?.isNewUser as Any)
                    print(authResult?.additionalUserInfo?.username as Any)
                    print(authResult?.additionalUserInfo?.profile as Any)
                    print(authResult?.credential as Any)
                    print(authResult?.user.displayName as Any)
                    self.name = authResult?.user.displayName ?? ""
//                    self.email = authResult?.user.email ?? ""
                    self.Uid = authResult?.user.uid ?? ""
                    //                self.UserId = authResult?.user.providerID ?? ""
                    //                self.password = "123456"

                }
            }
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

    // Unhashed nonce.
    fileprivate var currentNonce: String?

    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      var randomBytes = [UInt8](repeating: 0, count: length)
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }

      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

      let nonce = randomBytes.map { byte in
        // Pick a random character from the set, wrapping around if needed.
        charset[Int(byte) % charset.count]
      }

      return String(nonce)
    }

    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }

    @available(iOS 13, *)
    func startSignInWithAppleFlow() {
      let nonce = randomNonceString()
      currentNonce = nonce
      let appleIDProvider = ASAuthorizationAppleIDProvider()
      let request = appleIDProvider.createRequest()
      request.requestedScopes = [.fullName, .email]
      request.nonce = sha256(nonce)

      let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.performAutoFillAssistedRequests()
//      authorizationController.delegate = self
//      authorizationController.presentationContextProvider = self
      authorizationController.performRequests()
    }

}


extension VerifyPhoneViewModel{

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

    func GetCurrentlyUser(){
        Auth.auth().addStateDidChangeListener { auth, user in
            print(auth,user as Any)
            if user?.uid != nil{
            }
        }
    }
    func currentUser() -> Bool{
        if Auth.auth().currentUser != nil {
          // User is signed in.
          // ...
            print(Auth.auth().settings as Any)
            return true
        } else {
          // No user is signed in.
          // ...
            return false
        }
    }

    func LoginProvider(password:String){

        Auth.auth().addStateDidChangeListener { auth, user in
            print(auth,user as Any)

            guard user?.uid != nil else{return}

            _ = EmailAuthProvider.credential(withEmail: user!.uid, password: password)
        }
    }
    func GetUserProfile(){

        let user = Auth.auth().currentUser
        if let user = user {
          // The user's ID, unique to the Firebase project.
          // Do NOT use this value to authenticate with your backend server,
          // if you have one. Use getTokenWithCompletion:completion: instead.
            self.name = user.displayName ?? ""
            self.email = user.email ?? ""
            self.Uid = user.uid
            self.UserId = user.providerID
            self.password = "123456"
            self.IsVerfiyCode.toggle()
//            let uid = user.uid
//            let email = user.email
//            let pdi =  user.providerData.last?.providerID.utf8

            _ = user.photoURL
          var multiFactorString = "MultiFactor: "
          for info in user.multiFactor.enrolledFactors {
            multiFactorString += info.displayName ?? "[DispayName]"
            multiFactorString += " "
          }
//           ...
        }
    }

   func GetUserProviderSpecificProfileInformation(){
       if  let userInfo = Auth.auth().currentUser?.providerData[0]{
           //       cell?.textLabel?.text = userInfo?.providerID
           // Provider-specific UID
           self.Uid = userInfo.uid
           self.PhoneNumber = userInfo.phoneNumber ?? ""
           //       self.ProviderID = userInfo!.providerID
           print(userInfo as Any,"All\(String(describing: userInfo.debugDescription))")
       }

    }


    func UpdateUserProfile(_ displayName:String){

        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = self.name

        changeRequest?.commitChanges { error in
          // ...
            print(changeRequest?.displayName as Any)
            print(changeRequest?.photoURL as Any)
        }
    }
    func SetUserEmailAddress(email: String){

        Auth.auth().currentUser?.updateEmail(to: self.email) { error in

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
//    func Re_authenticateUser(){
//
//        let user = Auth.auth().currentUser
//        var credential: AuthCredential
//
//        // Prompt the user to re-provide their sign-in credentials
//
//        user?.reauthenticate(with: credential.provider.) { error,authData  in
//          if let error = error {
//            // An error happened.
//          } else {
//            // User re-authenticated.
//          }
//        }
//    }
}
