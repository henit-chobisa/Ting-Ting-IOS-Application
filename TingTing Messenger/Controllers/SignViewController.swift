//
//  SignViewController.swift
//  TingTing Messenger
//
//  Created by Henit Work on 16/04/21.
//

import UIKit
import Lottie
import Canvas
import FirebaseAuth

class SignViewController: UIViewController {
    

   
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var emailTextFeild: UITextField!

    @IBOutlet weak var friendsAnimation: AnimationView!
    @IBOutlet weak var backgroundSignUp: AnimationView!
    @IBOutlet weak var bunnyHoping: AnimationView!
    @IBOutlet weak var doggyAnimation: AnimationView!
    @IBOutlet weak var mainLogView: CSAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLogView.type = "zoomOut"
        mainLogView.delay = 5
        mainLogView.duration = 1
        friendsAnimation.isHidden = true
        bunnyHoping.loopMode = .playOnce
        bunnyHoping.contentMode = .scaleAspectFit
        bunnyHoping.play()
       
        emailTextFeild.layer.cornerRadius = 25
        passwordTextFeild.layer.cornerRadius = 25
        loginButton.layer.cornerRadius = 15
        
        
        
        DispatchQueue.main.async {
            self.mainLogView.startCanvasAnimation()
            
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            
            self.backgroundSignUp.loopMode = .playOnce
            self.backgroundSignUp.contentMode = .scaleAspectFill
            self.backgroundSignUp.play()
            self.friendsAnimation.isHidden = false
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.doggyAnimation.loopMode = .loop
            self.doggyAnimation.contentMode = .scaleAspectFill
            self.doggyAnimation.play()
            
            self.friendsAnimation.layer.cornerRadius = 60
            
            self.friendsAnimation.loopMode = .playOnce
            self.friendsAnimation.contentMode = .scaleAspectFill
            self.friendsAnimation.play()
        }
        
        

        
    }
    
    
    @IBAction func logbuttonhitted(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextFeild.text!, password: passwordTextFeild.text!) { (result, error) in
            
            self.performSegue(withIdentifier: "logtomain", sender: self)
            
        }
        
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
