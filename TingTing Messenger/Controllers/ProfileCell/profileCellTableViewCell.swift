//
//  profileCellTableViewCell.swift
//  TingTing Messenger
//
//  Created by Henit Work on 19/04/21.
//

import UIKit
import Lottie
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class profileCellTableViewCell: UITableViewCell {

    var table = UITableView()
    var indexp = IndexPath()
    @IBOutlet weak var backGroundImage: UIImageView!
    var data : [ProfileCell] = []
    var database = Firestore.firestore()
    var indexofcell : Int = 0
    @IBOutlet weak var deleteAnimation: AnimationView!
    @IBOutlet weak var acceptAnimationView: AnimationView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var switchConstant = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.cornerRadius = 25
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        acceptAnimationView.contentMode = .scaleAspectFit
        acceptAnimationView.loopMode = .loop
        acceptAnimationView.play()
        
        deleteAnimation.contentMode = .scaleAspectFit
        deleteAnimation.loopMode = .loop
        deleteAnimation.play()
        
    }
    
    
    func del(){
        print("Element Popped")
    }
    
    
    @IBAction func acceptButtonPressed(_ sender: UIButton) {
        
        if switchConstant == 0 {
            database.collection(email.text!).document("Requests").collection("Request").addDocument(data: ["Email" : (Auth.auth().currentUser?.email)!])
            backGroundImage.image = UIImage(named: "profileRequestSent")
            
        }
        
        else {
            database.collection((Auth.auth().currentUser?.email)!).getDocuments { (query, error) in
                if error == nil {
                    let documents = query?.documents
                    for doc in documents! {
                        let FullName = doc["FullName"] as! String
                        let City = doc["City"] as! String
                        let Age = doc["Age"] as! String
                        let Phone = doc["PhoneNumber"] as! String
                        let Description = doc["Profile Description"] as! String
                        let image = doc["UserImage"] as! String
                        self.database.collection(self.email.text!).document("UserFriends").collection("Friend").addDocument(data: ["Email" : (Auth.auth().currentUser?.email)!,"FullName" : FullName , "City" : City, "Age" : Age, "PhoneNumber" : Phone , "Description" : Description , "UserImage" : image])
                        self.acceptAnimationView.isHidden = true
                        self.deleteAnimation.isHidden = true
                        self.database.collection((Auth.auth().currentUser?.email)!).document("Requests").collection("Request").getDocuments { (query, error) in
                            let dataFirestore = query!.documents
                            for doc in dataFirestore{
                                if doc["Email"] as! String == self.email.text!{
                                    let id = doc.documentID
                                    self.database.collection((Auth.auth().currentUser?.email)!).document("Requests").collection("Request").document(id).delete()
                                    
                                    
                                }
                            }
                        }
                        
                        
                    }
                }
            }
            
            database.collection(email.text!).getDocuments { (query, error) in
                if error == nil {
                    let documents = query?.documents
                    for doc in documents! {
                        let FullName = doc["FullName"] as! String
                        let City = doc["City"] as! String
                        let Age = doc["Age"] as! String
                        let Phone = doc["PhoneNumber"] as! String
                        let Description = doc["Profile Description"] as! String
                        let image = doc["UserImage"] as! String
                        self.database.collection((Auth.auth().currentUser?.email)!).document("UserFriends").collection("Friend").addDocument(data: ["Email" : self.email.text!, "FullName" : FullName , "City" : City, "Age" : Age, "PhoneNumber" : Phone , "Description" : Description , "UserImage" : image])
                        
                    }
                }
            }
        }
        
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        del()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
