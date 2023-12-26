//
//  UserAuthModel.swift
//  BarberAppointmentsApp
//
//  Created by Rami Alaidy on 06/12/2023.
//

import SwiftUI
import GoogleSignIn
import FirebaseAuth
import CryptoKit
import AuthenticationServices
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FacebookCore
import FacebookAEM
import FBSDKLoginKit
class UserAuthModel: NSObject,ObservableObject, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return (self.viewsApple?.window!)!
    }


    let loginButton = FBLoginButton()


    @Published var givenName: String = ""
    @Published var email_provider: String = ""
    @Published var profilePicUrl: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    @Published var viewsApple: UIWindow?
    // Unhashed nonce.
    fileprivate var currentNonce: String?
    var GetSwitch: SwitchCheckEmail?
    var ViewTap : AnyView?
    @Published var IsEmailExesit : Bool = false
    let firebaseAuth = Auth.auth()
    override init(){
        super.init()
        check()
    }

    func checkStatus(){
        if(GIDSignIn.sharedInstance.currentUser != nil){
            let user = GIDSignIn.sharedInstance.currentUser
            guard let user = user else { return }
            let givenName = user.profile?.givenName
            let profilePicUrl = user.profile!.imageURL(withDimension: 100)!.absoluteString
            self.givenName = givenName ?? ""
            self.profilePicUrl = profilePicUrl
            self.email_provider = user.profile!.email
            self.isLoggedIn = true
        }else{
            self.isLoggedIn = false
            self.givenName = "Not Logged In"
            self.profilePicUrl =  ""
            self.email_provider = "None@barber.com"
//            ChechEmailExesit(Email: "")
        }
    }

    func check(){
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                self.errorMessage = "error: \(error.localizedDescription)"
            }
            self.SetEmailAddress(email: user?.profile!.email ?? "")
            self.SetUserPassword(password: "123456")
            self.SendverificationEmail()
            self.checkStatus()
        }
    }
    func ChechEmailExesit(Email: String){

        Auth.auth().fetchSignInMethods(forEmail: Email){ data,error in
            print(Email,data as Any,error?.localizedDescription as Any)

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
    func signIn(){
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}


        GIDSignIn.sharedInstance.signIn(
            withPresenting: presentingViewController) { signInResult, error in
                if let error = error {
                    self.errorMessage = "error: \(error.localizedDescription)"
                }
                guard let user = signInResult?.user, let idToken = user.idToken?.tokenString else { return }

                 let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                accessToken: user.accessToken.tokenString)

                Auth.auth().signIn(with: credential) { result, error in

                    print(result as Any)
                  // At this point, our user is signed in
                }

                self.checkStatus()

                user.refreshTokensIfNeeded { userRefresh, error in
                       guard error == nil else { return }
                       guard let user = userRefresh else { return }

                       let idToken = user.idToken
                       // Send ID token to backend (example below).
                    self.tokenSignInExample(idToken: idToken!.tokenString)
                   }

            }
    }

func tokenSignInExample(idToken: String) {
        guard let authData = try? JSONEncoder().encode(["idToken": idToken]) else {
            return
        }
        let url = URL(string: "https://bookingsaloonsapps-default-rtdb.europe-west1.firebasedatabase.app/tokensignin")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.uploadTask(with: request, from: authData) { data, response, error in
            // Handle response from your backend.
        }
        task.resume()
}
    // Set a user's email address
    func SetEmailAddress(email:String){
        let _: Void? = Auth.auth().currentUser?.updateEmail(to: email) { error in
            // ...
            guard error != nil else{
                print(error?.localizedDescription as Any)
                return
            }
            print("Set a user's email address \(email)")
        }
    }

    // Set a user's password
    func SetUserPassword(password:String){

        Auth.auth().currentUser?.updatePassword(to: password) { error in
          // ...
            guard error != nil else{
                print(error?.localizedDescription as Any)
                return
            }
            print("Set a user's password \(password)")
        }
    }
    // Send a user a verification email
    func  SendverificationEmail(){
        Auth.auth().currentUser?.sendEmailVerification { error in
            // ...
            guard error != nil else{
                print(error?.localizedDescription as Any)
                return
            }
            print("Send a user a verification email Done....!")
        }
    }
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        self.checkStatus()

    }
}
// Sign in With Apple
extension UserAuthModel{

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
      authorizationController.delegate = self
      authorizationController.presentationContextProvider = self
      authorizationController.performRequests()
    }

}

@available(iOS 13.0, *)
extension UserAuthModel : ASAuthorizationControllerDelegate {

  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
      guard let nonce = currentNonce else {
        fatalError("Invalid state: A login callback was received, but no login request was sent.")
      }
      guard let appleIDToken = appleIDCredential.identityToken else {
        print("Unable to fetch identity token")
        return
      }
      guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
        print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
        return
      }
      // Initialize a Firebase credential, including the user's full name.
      let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                        rawNonce: nonce,
                                                        fullName: appleIDCredential.fullName)
      // Sign in with Firebase.
      Auth.auth().signIn(with: credential) { (authResult, error) in
          if (error != nil) {
          // Error. If error.code == .MissingOrInvalidNonce, make sure
          // you're sending the SHA256-hashed nonce as a hex string with
          // your request to Apple.
              print(error?.localizedDescription as Any)
          return
        }
        // User is signed in to Firebase with Apple.
        // ...
      }
    }
  }

  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    // Handle error.
    print("Sign in with Apple errored: \(error)")
  }

}
// Fasebook login
import FacebookLogin
extension UserAuthModel:LoginButtonDelegate {

    func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
        if result != nil{

        }
    }
    


    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {

        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }




//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//      if let error = error {
//        print(error.localizedDescription)
//        return
//      }else{
//
//          print(result as Any)
//          let credentialFasebook = FacebookAuthProvider
//            .credential(withAccessToken: AccessToken.current!.tokenString)
//          // Initialize a Firebase credential.
//          let idTokenString = AuthenticationToken.current?.tokenString
//          let nonce = currentNonce
//          let credential = OAuthProvider.credential(withProviderID: "facebook.com",
//                                                    idToken: idTokenString!,
//                                                    rawNonce: nonce)
//          
//          Auth.auth().signIn(with: credential) { authResult, error in
//              if let error = error {
//                let authError = error as NSError
//                if  authError.code == AuthErrorCode.secondFactorRequired.rawValue {
//                  // The user is a multi-factor user. Second factor challenge is required.
//                  let resolver = authError
//                    .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
//                  var displayNameString = ""
//                  for tmpFactorInfo in resolver.hints {
//                    displayNameString += tmpFactorInfo.displayName ?? ""
//                    displayNameString += " "
//                  }
////                  self.showTextInputPrompt(
////                    withMessage: "Select factor to sign in\n\(displayNameString)",
////                    completionBlock: { userPressedOK, displayName in
////                      var selectedHint: PhoneMultiFactorInfo?
////                      for tmpFactorInfo in resolver.hints {
////                        if displayName == tmpFactorInfo.displayName {
////                          selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
////                        }
////                      }
////                      PhoneAuthProvider.provider()
////                        .verifyPhoneNumber(with: selectedHint!, uiDelegate: nil,
////                                           multiFactorSession: resolver
////                                             .session) { verificationID, error in
////                          if error != nil {
////                            print(
////                              "Multi factor start sign in failed. Error: \(error.debugDescription)"
////                            )
////                          } else {
//////                            self.showTextInputPrompt(
//////                              withMessage: "Verification code for \(selectedHint?.displayName ?? "")",
//////                              completionBlock: { userPressedOK, verificationCode in
//////                                let credential: PhoneAuthCredential? = PhoneAuthProvider.provider()
//////                                  .credential(withVerificationID: verificationID!,
//////                                              verificationCode: verificationCode!)
//////                                let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator
//////                                  .assertion(with: credential!)
//////                                resolver.resolveSignIn(with: assertion!) { authResult, error in
//////                                  if error != nil {
//////                                    print(
//////                                      "Multi factor finanlize sign in failed. Error: \(error.debugDescription)"
//////                                    )
//////                                  } else {
//////                                    self.navigationController?.popViewController(animated: true)
//////                                  }
//////                                }
//////                              }
//////                            )
////                          }
////                        }
////                    }
////                  )
//                } else {
////                  self.showMessagePrompt(error.localizedDescription)
//                  return
//                }
//                // ...
//                return
//              }
//              // User is signed in
//              // ...
//          }
//
//      }
//      // ...
//    }
    func setupLoginButton() {
        let nonce = randomNonceString()
          currentNonce = nonce
          loginButton.delegate = self
          loginButton.loginTracking = .limited
          loginButton.nonce = sha256(nonce)
    }
}
