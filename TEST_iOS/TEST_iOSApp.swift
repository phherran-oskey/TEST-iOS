//
//  TEST_iOSApp.swift
//  TEST_iOS
//
//  Created by Pierre-Hugo HERRAN on 08/01/2025.
//

import UIKit
import SwiftUI
import UserNotifications

// Step 1. Declare `UNUserNotificationCenterDelegate`
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application (_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        registerForNotifications()
        return true
    }

    // Step 2. Ask the user's permission to show alert notifications by calling the `requestAuthorization` method.
    func registerForNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                print("Permission granted: \(granted)")
            }
        UNUserNotificationCenter.current().delegate = self // Définir le délégué
    }

    // Step 3. Set up registration callback functions to check whether the registration fails or succeeds and display the notification.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    // Step 5. Schedule a local notification
    func scheduleLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Notification Test"
        content.body = "Ceci est une notification locale gratuite."
        content.sound = .default

        // Déclenchement dans 5 secondes
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // Créer la requête de notification
        let request = UNNotificationRequest(identifier: "localNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Erreur lors de l'ajout de la notification : \(error)")
            } else {
                print("Notification locale planifiée.")
            }
        }
    }
}

// MARK: Connect the app delegate to the SwiftUI app lifecycle
@main
struct TEST_iOSApp: App {
    // Step 4. Connect the `AppDelegate` class to the SwiftUI app’s lifecycle
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    // Exemple de déclenchement de notification lors de l'apparition de la vue
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        appDelegate.scheduleLocalNotification()
                    }
                }
        }
    }
}


