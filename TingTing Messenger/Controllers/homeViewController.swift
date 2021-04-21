//
//  homeViewController.swift
//  TingTing Messenger
//
//  Created by Henit Work on 18/04/21.
//

import UIKit
import Lottie
import Kingfisher
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import UserNotifications

class homeViewController: UIViewController, UNUserNotificationCenterDelegate {

    @IBOutlet weak var postAnimation: AnimationView!
    var notificationCenter = UNUserNotificationCenter.current()
   
    @IBOutlet weak var messagingAnimation: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagingAnimation.contentMode = .scaleAspectFill
        messagingAnimation.loopMode = .loop
        
        postAnimation.contentMode = .scaleAspectFill
        postAnimation.loopMode = .loop
       
        notificationCenter.requestAuthorization(options: [.alert , .sound ]) { (success, error) in
            if success {
                print("Notification Permission Garanted")
            }
        }
        
        notificationCenter.delegate = self
        let content = UNMutableNotificationContent()
        content.body = "This is a Test Notification"
        content.title = "Test Notification"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let identifier = "Main Identifier"
        let request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
            if error != nil {
                print(error?.localizedDescription)
            }
        }
        

        
        
    
        DispatchQueue.main.async {
            self.messagingAnimation.play()
            self.postAnimation.play()
        }

        // Do any additional setup after loading the view.
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert , .sound])
    }
    
}
