//
//  ProfileInformationViewController.swift
//  TingTing Messenger
//
//  Created by Henit Work on 17/04/21.
//

import UIKit
import Lottie


class ProfileInformationViewController: UIViewController {
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var backButtonAnimation: AnimationView!
    @IBOutlet weak var catballAnimation: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButtonAnimation.loopMode = .loop
        backButtonAnimation.contentMode = .scaleAspectFill
        catballAnimation.loopMode = .loop
        catballAnimation.contentMode = .scaleAspectFit
        
        
        DispatchQueue.main.async {
     
            self.catballAnimation.play()
            self.backButtonAnimation.play()
        }
        

     
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
