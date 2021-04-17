//
//  RegisterViewController.swift
//  TingTing Messenger
//
//  Created by Henit Work on 16/04/21.
//

import UIKit
import Lottie
import FirebaseAuth


class RegisterViewController: UIViewController {

    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var googleAnimation: AnimationView!
    @IBOutlet weak var facebookAnimation: AnimationView!
    @IBOutlet weak var appleAnimation: AnimationView!
    @IBOutlet weak var nestButton: UIButton!
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var happyCatAnimation: AnimationView!
    @IBOutlet weak var backButtonAnimation: AnimationView!
    @IBOutlet var registerViewBackground: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerViewBackground.loopMode = .playOnce
        registerViewBackground.contentMode = .scaleAspectFill
        backButtonAnimation.loopMode = .loop
        backButtonAnimation.contentMode = .scaleAspectFill
        
        backButtonAnimation.loopMode = .loop
        backButtonAnimation.contentMode = .scaleAspectFill
        
        happyCatAnimation.loopMode = .loop
        happyCatAnimation.contentMode = .scaleAspectFit
        
        appleAnimation.loopMode = .loop
        appleAnimation.contentMode = .scaleAspectFill
        activity.isHidden = true
        
        facebookAnimation.loopMode = .loop
        facebookAnimation.contentMode = .scaleAspectFill
        
        googleAnimation.loopMode = .loop
        googleAnimation.contentMode = .scaleAspectFill
        
        appleAnimation.isHidden = true
        facebookAnimation.isHidden = true
        googleAnimation.isHidden = true
        
        emailTextFeild.layer.cornerRadius = 20
        passwordTextFeild.layer.cornerRadius = 20
        nestButton.layer.cornerRadius = 20
        
        
        googleAnimation.layer.cornerRadius = 35
        
        
        DispatchQueue.main.async {
            self.registerViewBackground.play()
            self.backButtonAnimation.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.happyCatAnimation.play()
                self.appleAnimation.isHidden = false
                self.facebookAnimation.isHidden = false
                self.googleAnimation.isHidden = false
                
                self.appleAnimation.play()
                self.facebookAnimation.play()
                self.googleAnimation.play()
                
            }
        }
        
        

     
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func nextPressed(_ sender: UIButton) {
        activity.isHidden = false
        activity.startAnimating()
        
        Auth.auth().createUser(withEmail: emailTextFeild.text!, password: passwordTextFeild.text!) { (result, error) in
            if error != nil {
                print("There is an error in signup")
                
            }
            else {
                self.performSegue(withIdentifier: "toinformation", sender: self)
            }
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
