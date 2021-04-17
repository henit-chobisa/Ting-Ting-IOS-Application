//
//  photoPickerViewController.swift
//  TingTing Messenger
//
//  Created by Henit Work on 17/04/21.
//

import UIKit
import Lottie

class photoPickerViewController: UIViewController, UINavigationControllerDelegate {
    var picker = UIImagePickerController()
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var flyingcatanimation: AnimationView!
    @IBOutlet weak var launchButton: UIButton!
    @IBOutlet weak var descriptionTextFeild: UITextView!
    @IBOutlet weak var catAnimation: AnimationView!
    @IBOutlet weak var backButton: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        userImageView.layer.cornerRadius = 170/2
        backButton.contentMode = .scaleAspectFill
        backButton.loopMode = .loop
        
        catAnimation.contentMode = .scaleAspectFit
        catAnimation.loopMode = .loop
        
        flyingcatanimation.contentMode = .scaleAspectFill
        flyingcatanimation.loopMode = .loop
        
        userImageView.layer.borderWidth = 1
        userImageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        descriptionTextFeild.layer.cornerRadius = 30
        launchButton.layer.cornerRadius = 20
        
        
        
        DispatchQueue.main.async {
            self.backButton.play()
            self.catAnimation.play()
            self.flyingcatanimation.play()
        }
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func imageChanged(_ sender: UIButton) {
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
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

extension photoPickerViewController : UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        
        dismiss(animated: true)
        userImageView.image = image
    }
    
    
}
