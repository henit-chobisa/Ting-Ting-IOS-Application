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

class friendsViewController: UIViewController {
    var users : [ProfileCell] = []

    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var friendAnimationView: AnimationView!
    @IBOutlet weak var segmentor: UISegmentedControl!
    @IBOutlet weak var searchTextField: UITextField!
    
    let database = Firestore.firestore()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUsers()
        
        friendAnimationView.contentMode = .scaleAspectFit
        friendAnimationView.loopMode = .loop
        friendAnimationView.play()
//        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.register(UINib.init(nibName: "profileCellTableViewCell", bundle: nil), forCellReuseIdentifier: "profileCell")
        

        usersTableView.rowHeight = 80
        searchTextField.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func loadUsers(){
        
        users = []
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
    
    
    @IBAction func segmentorChanged(_ sender: UISegmentedControl) {
    }

}


//extension friendsViewController : UITableViewDelegate{
//
//}

extension friendsViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! profileCellTableViewCell
        
        cell.indexofcell = indexPath.row
        cell.displayName.text = users[indexPath.row].displayName
        cell.email.text = users[indexPath.row].email
        let resourse = ImageResource(downloadURL: URL(string: users[indexPath.row].imageURL)!)
        cell.profileImage.kf.setImage(with: resourse)
        
        
        
        
        return cell
    }


}
