//
//  LocalNotificationBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Miguel Mañas Alvarez on 19/10/24.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    
    static let instance = NotificationManager() // Singleton
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Success")
            }
        }
    }
    func scheduleNotifications() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification"
        content.subtitle = "This was soooo easy!"
        content.sound = .default
        content.badge = 1
        
        //time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        //calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 20
//        dateComponents.minute = 26
//        dateComponents.weekday = 6
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        //location
        let coordinates = CLLocationCoordinate2D(latitude: 40.00, longitude: 50.00)
        let region = CLCircularRegion(center: coordinates,
                                      radius: 100,
                                      identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = false
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request Permission") {
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("Schedule Notification") {
                NotificationManager.instance.scheduleNotifications()
            }
            
            Button("Cancel Notification") {
                NotificationManager.instance.cancelNotification()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotificationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationBootcamp()
    }
}
