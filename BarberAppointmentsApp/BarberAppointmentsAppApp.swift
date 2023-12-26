//
//  BarberAppointmentsAppApp.swift
//  BarberAppointmentsApp
//
//  Created by Rami Alaidy on 28/11/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseMessaging
import UserNotifications
import Firebase
import GoogleSignIn
import FacebookCore


//class AppDelegate: NSObject, UIApplicationDelegate{
//    let gcmMessageIDKey = "gcm.message_id"
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//
//        // Set deepLinkURLScheme to the custom URL scheme you defined in your
//          // Xcode project.
////        FirebaseOptions.defaultOptions()?.deepLinkURLScheme = customURLScheme
//        FirebaseApp.configure()
//        Messaging.messaging().delegate = self
//        let user = Auth.auth().currentUser
//        let uid = user?.uid
//        let pushManager = PushNotificationManager(userID: uid ?? "nil")
//        pushManager.registerForPushNotifications()
//
//        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
//           if error != nil || user == nil {
//             // Show the app's signed-out state.
//           } else {
//             // Show the app's signed-in state.
//           }
//         }
//        return true
//    }
//    let url = URL(string: "myphotoapp:Vacation?index=1")
//
//    func open(
//        _ url: URL,
//        options: [UIApplication.OpenExternalURLOptionsKey : Any] = [:],
//        completionHandler completion: ((Bool) -> Void)? = nil){
//
//            UIApplication.shared.open(url) { (result) in
//            if result {
//                // The URL was delivered successfully!
//                print(result)
//            }
//        }
//    }
//    // Dynamic Link Firebase /////
//
//    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
//                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
//
//      let handled = DynamicLinks.dynamicLinks()
//        .handleUniversalLink(userActivity.webpageURL!) { dynamiclink, error in
//          // ...
//            guard error != nil else{
//                return print(error?.localizedDescription as Any)
//            }
//     TeamAcceptEmailLinkView(email: "Ramialaidy.ra@gmail.com")
//            print(dynamiclink?.url as Any)
//        }
//
//      return handled
//    }
//    func application(_ app: UIApplication, open url: URL,
//                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//
//        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
//
//        if Auth.auth().canHandle(url) {
//           return Auth.auth().canHandle(url)
//        }
//        if GIDSignIn.sharedInstance.handle(url){
//            return GIDSignIn.sharedInstance.handle(url)
//        }
//
//        // Determine who sent the URL.
//            let sendingAppID = options[.sourceApplication]
//            print("source application = \(sendingAppID ?? "Unknown")")
//
//        open(url)
//        return application(app, open: url,sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,annotation: "")
//
//
//        // other URL handling goes here.
//
//
//    }
//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?,
//                     annotation: Any) -> Bool {
//        if DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) != nil {
//        // Handle the deep link. For example, show the deep-linked content or
//        // apply a promotional offer to the user's account.
//        // ...
//                // Process the URL.
//                guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
//                    let albumPath = components.path,
//                    let params = components.queryItems else {
//                        print("Invalid URL or album path missing")
//                        return false
//                }
//                if let photoIndex = params.first(where: { $0.name == "index" })?.value {
//                    print("albumPath = \(albumPath)")
//                    print("photoIndex = \(photoIndex)")
//                    return true
//                } else {
//                    print("Photo index missing")
//                    return false
//                }
//
////        return true
//      }
//      return false
//    }
//    // [START receive_message]
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
//                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        // If you are receiving a notification message while your app is in the background,
//        // this callback will not be fired till the user taps on the notification launching the application.
//        // TODO: Handle data of notification
//        // With swizzling disabled you must let Messaging know about the message, for Analytics
//        // Messaging.messaging().appDidReceiveMessage(userInfo)
//        // Print message ID.
//
//        let firebaseAuth = Auth.auth()
//        Messaging.messaging().appDidReceiveMessage(userInfo)
//        print(userInfo)
//
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//            let dataDict:[String: String] = ["token": "\(messageID)" ]
//            NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//            print(dataDict)
//        }
//        if (firebaseAuth.canHandleNotification(userInfo)){
//            completionHandler(.newData)
//            return
//        }
//        //          if Auth.auth().canHandleNotification(notification) {
//        //                  completionHandler(.noData)
//        //                  return
//        //              }
//        // This notification is not auth related; it should be handled separately.
//        // Print full message.
//        print(userInfo)
//
//        completionHandler(UIBackgroundFetchResult.newData)
//    }
//    // [END receive_message]
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        print("Unable to register for remote notifications: \(error.localizedDescription)")
//    }
//
//    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
//    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
//    // the FCM registration token.
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        print("APNs token retrieved: \(deviceToken)")
//
//        // Pass device token to auth
//        Auth.auth().setAPNSToken(deviceToken, type: .prod)
//
//        // Further handling of the device token if needed by the app
//        // ...
//        // With swizzling disabled you must set the APNs token here.
//        // Messaging.messaging().apnsToken = deviceToken
//    }
//    func applicationWillResignActive(_ application: UIApplication) {
//        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//    }
//
//    func applicationDidEnterBackground(_ application: UIApplication) {
//        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    }
//
//    func applicationWillEnterForeground(_ application: UIApplication) {
//        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    }
//
//    func applicationDidBecomeActive(_ application: UIApplication) {
//        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    }
//
//    func applicationWillTerminate(_ application: UIApplication) {
//        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//        // Saves changes in the application's managed object context before the application terminates.
//        //        self.saveContext()
//    }
//
//    // SceneDelegate.swift
//
//    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
//        guard let url = URLContexts.first?.url else {
//            return
//        }
//
//        ApplicationDelegate.shared.application(
//            UIApplication.shared,
//            open: url,
//            sourceApplication: nil,
//            annotation: [UIApplication.OpenURLOptionsKey.annotation]
//        )
//    }
//    func scene(_ scene: UIScene,
//               willConnectTo session: UISceneSession,
//               options connectionOptions: UIScene.ConnectionOptions) {
//
//
//        // Determine who sent the URL.
//        if let urlContext = connectionOptions.urlContexts.first {
//
//
//            let sendingAppID = urlContext.options.sourceApplication
//            let url = urlContext.url
//            print("source application = \(sendingAppID ?? "Unknown")")
//            print("url = \(url)")
//
//
//            // Process the URL similarly to the UIApplicationDelegate example.
//        }
//    }
//}
@main
struct BarberAppointmentsAppApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    let persistenceController = PersistenceController.shared

    @StateObject var userAuth: UserAuthModel =  UserAuthModel()
    @StateObject  var loginEmailVM = LoginEmailViewModel()
    @StateObject  var verfiyVM = VerifyPhoneViewModel()
    @StateObject  var UserBarberModelData = UserBareberViewModel()
    @StateObject private var approveTimer = ApproveTimerManager()
    @StateObject var ProfileVM = ProfileSettingsViewModel()
    @StateObject var AddBarberVM = AddBarberViewModel()
    @StateObject var locationManager = LocationManager()
    @StateObject var StaffViewModel = StaffManagementViewModel()
    var body: some Scene {
        WindowGroup {
            EmailCheckAndFetchView()
                .environmentObject(userAuth)
                .environmentObject(loginEmailVM)
                .environmentObject(verfiyVM)
                .environmentObject(UserBarberModelData)
                .environmentObject(approveTimer)
                .environmentObject(ProfileVM)
                .environmentObject(AddBarberVM)
                .environmentObject(locationManager)
                .environmentObject(StaffViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onOpenURL { url in
                    print("Received URL: \(url)")
                }
                .onOpenURL { url in
                        GIDSignIn.sharedInstance.handle(url)
                    print("Received URL: \(url)")
                      }
                .onAppear {
                    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                        // Check if `user` exists; otherwise, do something with `error`
                    }
                }
        }
    }
}


//@available(iOS 10, *)
//extension AppDelegate : UNUserNotificationCenterDelegate {
//
//  // Receive displayed notifications for iOS 10 devices.
//  func userNotificationCenter(_ center: UNUserNotificationCenter,
//                              willPresent notification: UNNotification,
//    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//    let userInfo = notification.request.content.userInfo
//
//    // With swizzling disabled you must let Messaging know about the message, for Analytics
//    // Messaging.messaging().appDidReceiveMessage(userInfo)
//    // [START_EXCLUDE]
//    // Print message ID.
//    if let messageID = userInfo[gcmMessageIDKey] {
//      print("Message ID: \(messageID)")
//        let dataDict:[String: String] = ["token": "\(messageID)" ]
//    NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//        print(dataDict)
//    }
//    // [END_EXCLUDE]
//    // Print full message.
//    print(userInfo)
//
//    // Change this to your preferred presentation option
//      completionHandler([[.badge,.banner, .sound]])
//  }
//
//  func userNotificationCenter(_ center: UNUserNotificationCenter,
//                              didReceive response: UNNotificationResponse,
//                              withCompletionHandler completionHandler: @escaping () -> Void) {
//    let userInfo = response.notification.request.content.userInfo
//
//    // [START_EXCLUDE]
//    // Print message ID.
//    if let messageID = userInfo[gcmMessageIDKey] {
//      print("Message ID: \(messageID)")
//        let dataDict:[String: String] = ["token": "\(messageID)" ]
//    NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//        print(dataDict)
//    }
//    // [END_EXCLUDE]
//    // With swizzling disabled you must let Messaging know about the message, for Analytics
//    // Messaging.messaging().appDidReceiveMessage(userInfo)
//    // Print full message.
//    print(userInfo)
//
//    completionHandler()
//  }
//}
// [END ios_10_message_handling]
//extension AppDelegate : MessagingDelegate {
//  // [START refresh_token]
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//    print("Firebase registration token: \(String(describing: fcmToken))")
//
//        let dataDict:[String: String] = ["token": fcmToken ?? "" ]
//    NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//        print(dataDict)
//    // TODO: If necessary send token to application server.
//    // Note: This callback is fired at each app startup and whenever a new token is generated.
//  }
//  // [END refresh_token]
//}

//class PushNotificationManager: NSObject, MessagingDelegate, UNUserNotificationCenterDelegate {
//    let userID: String
//
//    init(userID: String) {
//        self.userID = userID
//        super.init()
//    }
//    func registerForPushNotifications() {
//        if #available(iOS 10.0, *) {
//            // For iOS 10 display notification (sent via APNS)
//            UNUserNotificationCenter.current().delegate = self
//            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization(
//                options: authOptions,
//                completionHandler: {_, _ in })
//            // For iOS 10 data message (sent via FCM)
//            Messaging.messaging().delegate = self
//        } else {
//            let settings: UIUserNotificationSettings =
//                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            UIApplication.shared.registerUserNotificationSettings(settings)
//        }
//        UIApplication.shared.registerForRemoteNotifications()
//       // updateFirestorePushTokenIfNeeded()
//    }
//
//    func updateFirestorePushTokenIfNeeded(_ data:[String:Any]) {
//        if let token = Messaging.messaging().fcmToken {
////            let usersRef = Firestore.firestore().collection("RequestOrder").document(userID)
////            usersRef.collection("1").addDocument(data: data)
//            //usersRef.setData(data)
////            usersRef.setData(["fcmToken": token], merge: true)
//            let dataDict:[String: String] = ["token": token ]
//        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//            print(dataDict)
//            print(token)
//
//        }
//
//    }
////    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
////        print(remoteMessage.appData)
////    }
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
////        updateFirestorePushTokenIfNeeded([:])
//
//        if let messageID = fcmToken {
//          print("Message ID: \(messageID)")
//            let dataDict:[String: String] = ["token": "\(messageID)" ]
//        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//            print(dataDict)
//        }
//
//    }
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        print(response)
//    }
//}
