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

    var data : [ProfileCell] = []
    var database = Firestore.firestore()
    var indexofcell : Int = 0
    @IBOutlet weak var deleteAnimation: AnimationView!
    @IBOutlet weak var acceptAnimationView: AnimationView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
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
        database.collection(email.text!).addDocument(data: ["Email" : (Auth.auth().currentUser?.email)!])
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        del()
    }
    
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
