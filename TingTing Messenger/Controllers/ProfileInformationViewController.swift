//
//  ProfileInformationViewController.swift
//  TingTing Messenger
//
//  Created by Henit Work on 17/04/21.
//

import UIKit
import Lottie


class ProfileInformationViewController: UIViewController {
    @IBOutlet weak var backButtonAnimation: AnimationView!
    @IBOutlet var registerViewBackground: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerViewBackground.loopMode = .playOnce
        registerViewBackground.contentMode = .scaleAspectFill
        backButtonAnimation.loopMode = .loop
        backButtonAnimation.contentMode = .scaleAspectFill
        
        
        DispatchQueue.main.async {
            self.registerViewBackground.play()
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
