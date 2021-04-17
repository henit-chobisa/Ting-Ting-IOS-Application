//
//  ProfileInformationViewController.swift
//  TingTing Messenger
//
//  Created by Henit Work on 17/04/21.
//

import UIKit
import Lottie
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore


class ProfileInformationViewController: UIViewController {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var stepperButton: UIStepper!
    @IBOutlet weak var stepperVal: UILabel!
    @IBOutlet weak var cityFeild: UITextField!
    @IBOutlet weak var fullNameFeild: UITextField!
    @IBOutlet weak var phoneNumberFeild: UITextField!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var backButtonAnimation: AnimationView!
    @IBOutlet weak var catballAnimation: AnimationView!
    let db = Firestore.firestore()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButtonAnimation.loopMode = .loop
        backButtonAnimation.contentMode = .scaleAspectFill
        catballAnimation.loopMode = .loop
        catballAnimation.contentMode = .scaleAspectFill
        
        
        nextButton.layer.cornerRadius = 20
        stepperButton.layer.cornerRadius = 10
        cityFeild.layer.cornerRadius = 15
        fullNameFeild.layer.cornerRadius = 15
        phoneNumberFeild.layer.cornerRadius = 15
        activity.isHidden = true
        
        
        
        DispatchQueue.main.async {
     
            self.catballAnimation.play()
            self.backButtonAnimation.play()
        }
        

     
    }
    
    @IBAction func stepperValueChnaged(_ sender: UIStepper) {
        stepperVal.text = "\(sender.value)"
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        activity.isHidden = false
        let change = Auth.auth().currentUser?.createProfileChangeRequest()
        change?.displayName = fullNameFeild.text!
        
        db.collection((Auth.auth().currentUser?.email)!).addDocument(data: ["FullName" : fullNameFeild.text! , "PhoneNumber" : phoneNumberFeild.text! , "Age" : stepperVal.text! , "City" : cityFeild.text!])
        
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "tophoto", sender: self)
        }
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
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
