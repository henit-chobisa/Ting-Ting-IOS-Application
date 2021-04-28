//
//  friendsViewController.swift
//  TingTing Messenger
//
//  Created by Henit Work on 18/04/21.
//

import UIKit
import Lottie
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import Kingfisher
import UserNotifications

class friendsViewController: UIViewController, UITextFieldDelegate, UNUserNotificationCenterDelegate {
    var users : [ProfileCell] = []
    var filtereddata : [ProfileCell] = []
    var filtered = false

    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var friendAnimationView: AnimationView!
    @IBOutlet weak var segmentor: UISegmentedControl!
    @IBOutlet weak var searchTextField: UITextField!
    
    let database = Firestore.firestore()
    let center = UNUserNotificationCenter.current()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUsers()
        
        
        friendAnimationView.contentMode = .scaleAspectFit
        friendAnimationView.loopMode = .loop
        friendAnimationView.play()
        
        center.delegate = self

        usersTableView.dataSource = self
        searchTextField.delegate = self
        usersTableView.register(UINib.init(nibName: "profileCellTableViewCell", bundle: nil), forCellReuseIdentifier: "profileCell")
        
        

        usersTableView.rowHeight = 80
        searchTextField.layer.cornerRadius = 20
       
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text {
                     if string.count == 0 {
                         filterText(String(text.dropLast()))
                     } else {
                         filterText(text + string)
                     }
                     
                 }
        
        return true
    }
    
    func filterText(_ query : String?){
        guard let query = query else {
            return
        }
        filtereddata.removeAll()
        for element in users {
            if element.displayName.lowercased().starts(with: query.lowercased()){
                filtereddata.append(element)
            }
        }
        usersTableView.reloadData()
        filtered = true
        
    }
    
    
    func loadUsers(){
        if segmentor.selectedSegmentIndex == 0
        {
            filtereddata = []
            users = []
            filtered = false
            database.collection("userList").addSnapshotListener { (query, error) in
                let data = query?.documents
                for doc in data! {
                    let displayName = doc["FullName"] as! String
                    let email = doc["Email"] as! String
                    let image = doc["UserImage"] as! String
                    
                    let pod = ProfileCell.init(displayName: displayName, email: email, imageURL: image)
                    self.users.append(pod)
                }
                self.usersTableView.reloadData()
            }
        }
        
        else if segmentor.selectedSegmentIndex == 1
        {
            users = []
            filtereddata = []
            filtered = false
            database.collection((Auth.auth().currentUser?.email)!).document("UserFriends").collection("Friend").addSnapshotListener { (query, error) in
                if let data = query?.documents{
                    for doc in data {
                        if let displayName = doc["FullName"] as? String ,let email = doc["Email"] as? String, let image = doc["UserImage"] as? String {
                            let pod = ProfileCell.init(displayName: displayName, email: email, imageURL: image)
                            self.users.append(pod)
                        }
                    }
                    self.usersTableView.reloadData()
                }
                
            }
        }
        
        
        else {
            users = []
            filtereddata = []
            filtered = false
            database.collection((Auth.auth().currentUser?.email)!).document("Requests").collection("Request").addSnapshotListener { (query, error) in
                if let data = query?.documents{
                    for doc in data {
                        if let email = doc["Email"] as? String {
                        
                            self.database.collection(email).addSnapshotListener { (query2, error2) in
                                let data2 = query2!.documents
                                for doc in data2{
                                    let displayName2 = doc["FullName"] as! String
                                    let email2 = email
                                    let image2 = doc["UserImage"] as! String
                                 
                                    let pod = ProfileCell.init(displayName: displayName2, email: email2, imageURL: image2)
                                    self.users.append(pod)
                                }
                                self.usersTableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func segmentorChanged(_ sender: UISegmentedControl) {
        
        loadUsers()
        usersTableView.reloadData()
        
        
    }

}

extension friendsViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filtereddata.isEmpty {
            return filtereddata.count
        }
        return filtered ? 0 : users.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! profileCellTableViewCell
        cell.indexp = indexPath
        cell.table = usersTableView
        
        if segmentor.selectedSegmentIndex == 1
        {
            if !filtereddata.isEmpty
            {
                cell.acceptAnimationView.isHidden = true
                cell.deleteAnimation.isHidden = true
                cell.indexofcell = indexPath.row
                cell.displayName.text = filtereddata[indexPath.row].displayName
                cell.email.text = filtereddata[indexPath.row].email
                let resourse = ImageResource(downloadURL: URL(string: filtereddata[indexPath.row].imageURL)!)
                cell.profileImage.kf.setImage(with: resourse)
                
            }
            else
            {
                cell.acceptAnimationView.isHidden = true
                cell.deleteAnimation.isHidden = true
                cell.indexofcell = indexPath.row
                cell.displayName.text = users[indexPath.row].displayName
                cell.email.text = users[indexPath.row].email
                let resourse = ImageResource(downloadURL: URL(string: users[indexPath.row].imageURL)!)
                cell.profileImage.kf.setImage(with: resourse)
                
            }
            
        }
        else if segmentor.selectedSegmentIndex == 2
        {
            if !filtereddata.isEmpty
            {
                cell.switchConstant = 1
                cell.acceptAnimationView.isHidden = false
                cell.deleteAnimation.isHidden = false
                cell.acceptAnimationView.animation = Animation.named("requestAccepted")
                cell.indexofcell = indexPath.row
                cell.acceptAnimationView.play()
                cell.deleteAnimation.play()
                cell.displayName.text = filtereddata[indexPath.row].displayName
                cell.email.text = filtereddata[indexPath.row].email
                let resourse = ImageResource(downloadURL: URL(string: filtereddata[indexPath.row].imageURL)!)
                cell.profileImage.kf.setImage(with: resourse)
                
            }
            else
            {
                cell.acceptAnimationView.isHidden = false
                cell.deleteAnimation.isHidden = false
                cell.switchConstant = 1
                cell.acceptAnimationView.animation = Animation.named("requestAccepted")
                cell.acceptAnimationView.play()
                cell.deleteAnimation.play()
                cell.indexofcell = indexPath.row
                cell.displayName.text = users[indexPath.row].displayName
                cell.email.text = users[indexPath.row].email
                let resourse = ImageResource(downloadURL: URL(string: users[indexPath.row].imageURL)!)
                cell.profileImage.kf.setImage(with: resourse)
                
            }
            
        }
        
        else
        {
            if !filtereddata.isEmpty
            {
                cell.acceptAnimationView.isHidden = false
                cell.deleteAnimation.isHidden = false
                cell.acceptAnimationView.animation = Animation.named("plus")
                cell.acceptAnimationView.play()
                cell.deleteAnimation.play()
                cell.indexofcell = indexPath.row
                cell.displayName.text = filtereddata[indexPath.row].displayName
                cell.email.text = filtereddata[indexPath.row].email
                let resourse = ImageResource(downloadURL: URL(string: filtereddata[indexPath.row].imageURL)!)
                cell.profileImage.kf.setImage(with: resourse)
                
            }
            else
            {
                cell.acceptAnimationView.isHidden = false
                cell.deleteAnimation.isHidden = false
                cell.acceptAnimationView.animation = Animation.named("plus")
                cell.acceptAnimationView.play()
                cell.deleteAnimation.play()
                cell.indexofcell = indexPath.row
                cell.displayName.text = users[indexPath.row].displayName
                cell.email.text = users[indexPath.row].email
                let resourse = ImageResource(downloadURL: URL(string: users[indexPath.row].imageURL)!)
                cell.profileImage.kf.setImage(with: resourse)
                
            }
            
        }
    
        
        return cell
    }


}
