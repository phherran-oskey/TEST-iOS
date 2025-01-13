//
//  TEST_watchOSApp.swift
//  TEST_watchOS Watch App
//
//  Created by Pierre-Hugo HERRAN on 08/01/2025.
//

import UIKit
import SwiftUI
import UserNotifications
import SwiftUI
import UserNotifications

@main
struct TEST_watchOS_Watch_AppApp: App {
    init() {
        registerForNotifications()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    // Exemple de déclenchement de notification sur watchOS
                    scheduleWatchNotification()
                }
        }
    }

    // Demander l'autorisation d'envoyer des notifications
    func registerForNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound]) { granted, error in
                print("Permission granted: \(granted)")
            }
    }

    // Planifier une notification locale sur watchOS
    func scheduleWatchNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Notification Watch"
        content.body = "Ceci est une notification locale sur la montre."
        content.sound = .default

        // Déclenchement dans 5 secondes
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // Créer la requête de notification
        let request = UNNotificationRequest(identifier: "watchNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Erreur lors de l'ajout de la notification : \(error)")
            } else {
                print("Notification locale planifiée sur la montre.")
            }
        }
    }
}
