//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Suhyoung Eo on 2021/09/08.
//

import UIKit
//import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    // navigation bar deacitve
    override func viewWillAppear(_ animated: Bool) {
        //superclass function override 하는 경우 꼭 superclass func를 먼저 호출 해야함
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // navigation bar active when change another view
    override func viewWillDisappear(_ animated: Bool) {
        //superclass function override 하는 경우 꼭 superclass func를 먼저 호출 해야함
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        titleLabel.text = "⚡️FlashChat"
        
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = K.appName

        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
        
    }
}
