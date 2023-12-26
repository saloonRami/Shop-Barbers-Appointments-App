//
//  AppDelegae+Extentions.swift
//  BarberAppointmentsApp
//
//  Created by Rami Alaidy on 25/12/2023.
//

import Foundation
import FirebaseDynamicLinks
import UIKit

//extension AppDelegate{
//
//    func handleInçomingDynamicLink(_ dynamicLink: DynamicLink) {
//
//        guard let url = dynamicLink.url else {
//            print("That's weird. My dynamic link object has no url")
//            return
//        }
//
//        print ("Your incoming link parameter is \(url.absoluteString)")
//
//        guard (dynamicLink.matchType == .unique || dynamicLink.matchType == .default) else {
//            // Not a strong enough match. Let's just not do anything
//            print("Not a strong enough match type to continue")
//            return
//        }
//
//        // Parse the link parameter
//        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
//              let queryItems = components.queryItems else { return }
//        if
//            components.path == "/recipes" {
//            // We are loading up a specific recipe.
//            if let recipeIDQueryItem = queryItems.first(where: {$0.name == "recipeID"}) {
//                guard let recipeID = recipeIDQueryItem.value else { return }
//
//                print(recipeID)
////                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
////                guard let newDetailVC = storyboard.instantiateViewController(withIdentifier:"recipeDetailViewController") as? RecipeDetailViewController else { return }
////                newDetailVC.getRecipeForID(recipeID)
////                (self.window?.rootViewController as? UINavigationController)?.pushViewController(newDetailVC, animated: true)
//            }
//        }
//    }
//}
