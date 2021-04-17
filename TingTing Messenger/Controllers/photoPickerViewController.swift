//
//  photoPickerViewController.swift
//  TingTing Messenger
//
//  Created by Henit Work on 17/04/21.
//

import UIKit
import Lottie
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth


class photoPickerViewController: UIViewController, UINavigationControllerDelegate {
    var fullName : String = ""
    var phoneNumber : String = ""
    var age : String = ""
    var city : String = ""
    let database = Firestore.firestore()
    var picker = UIImagePickerController()
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var flyingcatanimation: AnimationView!
    @IBOutlet weak var launchButton: UIButton!
    @IBOutlet weak var descriptionTextFeild: UITextView!
    @IBOutlet weak var catAnimation: AnimationView!
    @IBOutlet weak var backButton: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        userImageView.layer.cornerRadius = 170/2
        backButton.contentMode = .scaleAspectFill
        backButton.loopMode = .loop
        
        catAnimation.contentMode = .scaleAspectFit
        catAnimation.loopMode = .loop
        
        flyingcatanimation.contentMode = .scaleAspectFill
        flyingcatanimation.loopMode = .loop
        
        userImageView.layer.borderWidth = 1
        userImageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        descriptionTextFeild.layer.cornerRadius = 30
        launchButton.layer.cornerRadius = 20
        activity.isHidden = true
        
        
        
        DispatchQueue.main.async {
            self.backButton.play()
            self.catAnimation.play()
            self.flyingcatanimation.play()
        }
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func imageChanged(_ sender: UIButton) {
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func launchPressed(_ sender: UIButton) {
        activity.isHidden = false
        activity.startAnimating()
        
        let data = userImageView.image?.jpegData(compressionQuality: 0.7)
        let imagereference = Storage.storage().reference().child((Auth.auth().currentUser?.email)!).child("Profile Image")
        imagereference.putData(data!, metadata: nil){ (meta , error) in
            imagereference.downloadURL { (url, error) in
                self.helloDatabase(imageurl: url!)
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "regtomain", sender: self)
                }
                
            }
        }
    }
    
    
    func helloDatabase(imageurl : URL){
        
        Auth.auth().currentUser?.createProfileChangeRequest().photoURL = imageurl
        database.collection((Auth.auth().currentUser?.email)!).addDocument(data: ["FullName" : fullName,"PhoneNumber" : phoneNumber,"Age" : age,"City" : city ,"UserImage" : imageurl.absoluteString , "Profile Description" : descriptionTextFeild.text!])
        activity.stopAnimating()
        activity.isHidden = true
        
        
        
        
        
    }
    
    
    
   

}

extension photoPickerViewController : UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        
        dismiss(animated: true)
        userImageView.image = image
    }
    
    
}
