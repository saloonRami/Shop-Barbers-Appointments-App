//
//  EmailCheckAndFetchView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 02/11/2023.
//

import SwiftUI
import _AuthenticationServices_SwiftUI
import GoogleSignInSwift
import GoogleSignIn

struct EmailCheckAndFetchView: View {

    
    @State private var EmailValue: String = ""

    @EnvironmentObject var Vm: LoginEmailViewModel
    @EnvironmentObject var userAuthModel: UserAuthModel

    @State private var isLoading: Bool = false

    var body: some View {
        NavigationView{
            VStack{
                VStack(alignment: .center) {

                    Text("Saloon For busniss")
                        .font(.title)
                    .bold()
                    .padding(.top,4)
                    Text("Create an account or log in to manage your Fresha business.")
                        .font(.caption)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                }.padding([.top,.bottom],44)
                VStack{
                    TextField("Enter Your Eamil address", text: $EmailValue)
                        .textFieldStyle(.roundedBorder)
                        .padding([.top,.bottom],50)

                    Button(action: {
//                        self.Vm.ChechEmailExesit(Email: EmailValue)
//                        self.Vm.didTapSendSignInLink()
                        self.Vm.Logout()
                        self.isLoading = true

                    }, label: {
                        Text(self.isLoading ? "Loading......":"Countinue")
                                .frame(width: 300,height: 36)
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .background(.black)
                                .cornerRadius(16)
                    })
                    .fullScreenCover(isPresented: $Vm.IsEmailExesit){
                      self.Vm.ViewTap

                    }
                    .disabled(EmailValue.isEmpty)
                    .opacity(EmailValue.isEmpty ? 0.5:1.0)
                }.edgesIgnoringSafeArea(.all)

                VStack{

                    SignInWithAppleButton(
                        onRequest: { request in

                        },
                        onCompletion: { result in

                        })
                    .padding([.top,.bottom],24)

                    // Google Signin
                    GoogleSignInButton(action: handleSignInButton)

                }.frame(width: 300,height: 36)
                    .padding(.top,44)
                Spacer()
            }
            .padding(.all)
        }
    }
    func handleSignInButton() {
       userAuthModel.signIn()
//        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
//
//      GIDSignIn.sharedInstance.signIn(
//        withPresenting: presentingViewController) { signInResult, error in
//          guard let signInResult = signInResult else {
//            // Inspect error
//            print(error?.localizedDescription as Any)
//            return
//          }
//            // If sign in succeeded, display the app's main content View.
//
//            let user = signInResult.user
//
//            let emailAddress = user.profile?.email
//            let fullName = user.profile?.name
//            let givenName = user.profile?.givenName
//            let familyName = user.profile?.familyName
//            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
//
//            signInResult.user.refreshTokensIfNeeded { user, error in
//                guard error == nil else { return }
//                guard let user = user else { return }
//
//                let idToken = user.idToken
//                // Send ID token to backend (example below).
//                tokenSignInExample(idToken: idToken!.tokenString)
//            }
//
//        }
    }
    func tokenSignInExample(idToken: String) {
        guard let authData = try? JSONEncoder().encode(["idToken": idToken]) else {
            return
        }
        let url = URL(string: "https://barberreservationsapp-default-rtdb.firebaseio.com/tokensignin")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.uploadTask(with: request, from: authData) { data, response, error in
            // Handle response from your backend.
        }
        task.resume()
    }
}

#Preview {
    EmailCheckAndFetchView()
        .environmentObject(LoginEmailViewModel())
        .environmentObject(UserAuthModel())
}
