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

class homeViewController: UIViewController {

    @IBOutlet weak var postAnimation: AnimationView!
   
    @IBOutlet weak var messagingAnimation: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagingAnimation.contentMode = .scaleAspectFill
        messagingAnimation.loopMode = .loop
        
        postAnimation.contentMode = .scaleAspectFill
        postAnimation.loopMode = .loop
        
    
        DispatchQueue.main.async {
            self.messagingAnimation.play()
            self.postAnimation.play()
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
