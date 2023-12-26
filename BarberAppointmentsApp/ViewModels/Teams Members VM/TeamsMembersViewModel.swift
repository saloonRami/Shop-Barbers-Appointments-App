//
//  TeamsMembersViewModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 23/12/2023.
//

import Foundation
import FirebaseCore
import FirebaseDynamicLinks
import FirebaseAuth

class TeamsMembersViewModel: ObservableObject{

    @Published var email : String = ""
    @Published var url_domain : URL? = nil
    @Published var isSharePresented: Bool = false
    @Published private(set) var shortUrl : String?

    func SendEmailLinkToBarber(){

        let actionCodeSettings = ActionCodeSettings()
        guard url_domain != nil else{return}

        actionCodeSettings.url =  url_domain  //URL(string: shortUrl ?? "")  // URL(string:"https://linkteambarber.page.link/q9Ku")
        // The sign-in operation has to always be completed in the app.
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        actionCodeSettings.setAndroidPackageName("com.example.android",
                                                 installIfNotAvailable: false, minimumVersion: "12")

        Auth.auth().sendSignInLink(toEmail: email,
                                   actionCodeSettings: actionCodeSettings) { error in
          // ...
            if let error = error {
//              self.showMessagePrompt(error.localizedDescription)
                print(error.localizedDescription)
              return
            }
            // The link was successfully sent. Inform the user.
            // Save the email locally so you don't need to ask the user for it again
            // if they open the link on the same device.
            UserDefaults.standard.set(self.email, forKey: "Email")
//            self.showMessagePrompt("Check your email for link")
            print("\(self.email) Check your email for link")
            // ...
        }
    }

    func shareButtonWasTapped()  {
        // Let's create the dynamic link!
        //   guard let recipe = self.recipe else { return }
        // let linkParameter = URL(string: "https://bookingsaloonsapps.page.link/emaliaccount?recipeID=\(recipe.recipeID)
        
        //  components.host = "bookingsaloonsapps.web.app"
        //  components.host = "www.example.com/"
        //  components.path = "/emaliaccount"
        
        var components = URLComponents ()
        components.scheme = "https"
        components.host = "www.example.com"
        components.path = "/recipes"
        
        let recipeIDQueryItem = URLQueryItem(name: "recipeID", value: "\((0 ... 1000).randomElement() ?? 0)\((0 ... 1000).randomElement() ?? 0)")
        let emailOwner = URLQueryItem(name: "email_owner", value: "rami_alaidy")
        let shop_name = URLQueryItem(name: "shop_name", value: "Rami Beauty Saloon")
        
        components.queryItems = [recipeIDQueryItem]
        
        guard let linkParameter = components.url else { return }
        print("I am sharing \(linkParameter.absoluteString)")
        
        // Create the big dynamic link
        guard let shareLink = DynamicLinkComponents.init(link: linkParameter, domainURIPrefix: "https://linkteambarber.page.link") else{
            print("Couldn't create FDL components")
            return
        }
        if let myBundleId = Bundle.main.bundleIdentifier {
            shareLink.iOSParameters = DynamicLinkIOSParameters(bundleID: myBundleId)
        }
        // Temporarily use Google Photos
        shareLink.iOSParameters?.appStoreID = "0795838893"
        shareLink.androidParameters = DynamicLinkAndroidParameters(packageName: "com.example.reciperall")
        shareLink.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        
        shareLink.socialMetaTagParameters?.title = " Hello \(emailOwner.value?.description ?? "") \n Confirm Inivte\(email) from Recipe Rally"
        shareLink.socialMetaTagParameters?.descriptionText = "I received an invitation from Rami Barber Shop to join and work with him. \n Please complete the required steps"
        
        shareLink.socialMetaTagParameters?.imageURL = URL(string: "URL")
        
        guard let longURL = shareLink.url else { return  }
        print ("The long dynamic link is \(longURL.absoluteString)")
        
        shareLink.shorten { url, warnings, error in
            if let error = error {
                print("Oh no! Got an error! \(error)")
                return
            }
            if let warnings = warnings {
                for warning in warnings {
                    print ("FDL Warning: \(warning)")
                }
            }
            guard let shortUrl = url else{return}
            print("I have a short URL to share!\(shortUrl.absoluteString)")
            self.shortUrl = shortUrl.absoluteString
            self.showShareSheet(url: shortUrl)
        }
        
    }
    func showShareSheet (url: URL) {

        let promoText = "Check out this great recipe for \("self.recipe?.title") I found on Recipe Rally!"
        self.url_domain = url.absoluteURL
        self.isSharePresented = true
        self.SendEmailLinkToBarber()
    }
}
// Rami_alaidy@yahoo.com
