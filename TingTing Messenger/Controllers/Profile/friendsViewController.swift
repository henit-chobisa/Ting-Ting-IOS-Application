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

class friendsViewController: UIViewController {
    var users : [ProfileCell] = []

    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var friendAnimationView: AnimationView!
    @IBOutlet weak var segmentor: UISegmentedControl!
    @IBOutlet weak var searchTextField: UITextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        friendAnimationView.contentMode = .scaleAspectFit
        friendAnimationView.loopMode = .loop
        friendAnimationView.play()
//        usersTableView.delegate = self
//        usersTableView.dataSource = self
        

        searchTextField.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func segmentorChanged(_ sender: UISegmentedControl) {
    }

}


//extension friendsViewController : UITableViewDelegate{
//
//}
//
//extension friendsViewController : UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return users.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return  cell
//    }
//
//
//}
