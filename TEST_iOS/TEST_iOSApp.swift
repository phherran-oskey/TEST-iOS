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
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                granted, error in
                print("Permission granted: \(granted)")
            }
    }

    // Step 3. Set up registration callback functions to check whether the registration fails or succeeds and display the notification.

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
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
        }
    }
}
