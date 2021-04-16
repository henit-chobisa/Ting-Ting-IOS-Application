//
//  ViewController.swift
//  TingTing Messenger
//
//  Created by Henit Work on 15/04/21.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var pigeonView: AnimationView!
    @IBOutlet weak var app_logo: AnimationView!
    @IBOutlet weak var heart: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        app_logo.loopMode = .loop
        app_logo.contentMode = .scaleAspectFill
        app_logo.play()
        
        heart.loopMode = .loop
        heart.contentMode = .scaleAspectFill
        heart.play()
        
        pigeonView.loopMode = .loop
        pigeonView.contentMode = .scaleAspectFill
        pigeonView.play()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.performSegue(withIdentifier: "toSign", sender: self)
        }
    }


}

