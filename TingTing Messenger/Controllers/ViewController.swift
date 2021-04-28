//
//  ViewController.swift
//  TingTing Messenger
//
//  Created by Henit Work on 15/04/21.
//

import UIKit
import Lottie
import FirebaseAuth

class ViewController: UIViewController {

   
    @IBOutlet weak var app_logo: AnimationView!
    @IBOutlet weak var heart: AnimationView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.app_logo.play()
        self.heart.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        app_logo.loopMode = .loop
        app_logo.contentMode = .scaleAspectFill
        app_logo.play()
        
        heart.loopMode = .loop
        heart.contentMode = .scaleAspectFill
        heart.play()
        print(DateInterval.init().end)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.performSegue(withIdentifier: "toSign", sender: self)
        }
    }


}

