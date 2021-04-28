//
//  lookProfileViewController.swift
//  TingTing Messenger
//
//  Created by Henit Work on 18/04/21.
//

import UIKit
import Lottie
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore
import Kingfisher

class lookProfileViewController: UIViewController {

    @IBOutlet weak var requestAnimation: AnimationView!
    @IBOutlet weak var RequestButton: UIButton!
    @IBOutlet weak var bellAnimation: AnimationView!
    @IBOutlet weak var addFriendAnimation: AnimationView!
    let db = Firestore.firestore()
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var posts: UILabel!
    @IBOutlet weak var connections: UILabel!
    @IBOutlet weak var profileDescription: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        self.addFriendAnimation.play()
        self.bellAnimation.play()
        self.requestAnimation.play()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addFriendAnimation.contentMode = .scaleAspectFill
        addFriendAnimation.loopMode = .loop
        addFriendAnimation.play()
        
        bellAnimation.contentMode = .scaleAspectFill
        bellAnimation.loopMode = .loop
        bellAnimation.play()
        
        RequestButton.layer.cornerRadius = 20
        
        requestAnimation.contentMode = .scaleAspectFill
        requestAnimation.loopMode = .loop
        requestAnimation.play()
    
        
        
        profileImage.layer.cornerRadius = 110/2
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        
        
        
        
        db.collection((Auth.auth().currentUser?.email)!).getDocuments { (query, error) in
            for doc in query!.documents{
                let description = doc["Profile Description"] as! String
                let urlString = doc["UserImage"] as! String
                let name = doc["FullName"] as! String
                self.nameLable.text = name
                let url = URL.init(string: urlString)
                let source = ImageResource.init(downloadURL: url!)
                self.profileImage.kf.setImage(with: source)
                self.profileDescription.text = description
            }
        }

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func requestLoader(_ sender: UIButton) {
    }
    

}
