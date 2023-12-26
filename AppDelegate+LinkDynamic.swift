//
//  AppDelegate+LinkDynamic.swift
//  BarberAppointmentsApp
//
//  Created by Rami Alaidy on 26/12/2023.
//

import Foundation

import UIKit
// [START import]
import FirebaseCore
import FirebaseDynamicLinks
// [END import]

//@UIApplicationMain
class AppDelegate: NSObject, UIApplicationDelegate {
  var window: UIWindow?
  let customURLScheme = "linkteambarber"

  // [START didfinishlaunching]
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication
                     .LaunchOptionsKey: Any]?) -> Bool {
    // Set deepLinkURLScheme to the custom URL scheme you defined in your
    // Xcode project.
    FirebaseOptions.defaultOptions()?.deepLinkURLScheme = customURLScheme
    FirebaseApp.configure()

    return true
  }

  // [END didfinishlaunching]

  // [START openurl]
  @available(iOS 9.0, *)
  func application(_ app: UIApplication, open url: URL,
                   options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
    return application(app, open: url,
                       sourceApplication: options[UIApplication.OpenURLOptionsKey
                         .sourceApplication] as? String,
                       annotation: "")
  }

  func application(_ application: UIApplication, open url: URL, sourceApplication: String?,
                   annotation: Any) -> Bool {
    if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
      // Handle the deep link. For example, show the deep-linked content or
      // apply a promotional offer to the user's account.
      // [START_EXCLUDE]
      // In this sample, we just open an alert.
      handleDynamicLink(dynamicLink)
      // [END_EXCLUDE]
      return true
    }
    // [START_EXCLUDE silent]
    // Show the deep link that the app was called with.
    showDeepLinkAlertView(withMessage: "openURL:\n\(url)")
    // [END_EXCLUDE]
    return false
  }

  // [END openurl]

  // [START continueuseractivity]
  func application(_ application: UIApplication, continue userActivity: NSUserActivity,
                   restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    let handled = DynamicLinks.dynamicLinks()
      .handleUniversalLink(userActivity.webpageURL!) { dynamiclink, error in
        // [START_EXCLUDE]
        if let dynamiclink = dynamiclink {
          self.handleDynamicLink(dynamiclink)
        }
        // [END_EXCLUDE]
      }

    // [START_EXCLUDE silent]
    if !handled {
      // Show the deep link URL from userActivity.
      let message =
        "continueUserActivity webPageURL:\n\(userActivity.webpageURL?.absoluteString ?? "")"
      showDeepLinkAlertView(withMessage: message)
    }
    // [END_EXCLUDE]
    return handled
  }

  // [END continueuseractivity]

  func handleDynamicLink(_ dynamicLink: DynamicLink) {
    let matchConfidence: String
    if dynamicLink.matchType == .weak {
      matchConfidence = "Weak"
    } else {
      matchConfidence = "Strong"
    }
    let message = "App URL: \(dynamicLink.url?.absoluteString ?? "")\n" +
      "Match Confidence: \(matchConfidence)\nMinimum App Version: \(dynamicLink.minimumAppVersion ?? "")"
    showDeepLinkAlertView(withMessage: message)
  }

  func showDeepLinkAlertView(withMessage message: String) {
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    let alertController = UIAlertController(
      title: "Deep-link Data",
      message: message,
      preferredStyle: .alert
    )
    alertController.addAction(okAction)
    window?.rootViewController?.present(alertController, animated: true, completion: nil)
  }
}
