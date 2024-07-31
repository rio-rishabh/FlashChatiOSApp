//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel
import GoogleSignInSwift
import FirebaseAuth 
import GoogleSignIn

class WelcomeViewController: UIViewController {

    private let authViewModel = AuthenticationViewModel()
    @IBOutlet weak var titleLabel: CLTypingLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = K.appName
//        titleLabel.text = ""
//        var charIndex = 0.0
//        let titleText = "⚡️FlashChat"
//        for letter in titleText{
//            print("-")
//            print(0.1 * charIndex)
//            print(letter)
//            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
//                self.titleLabel.text?.append(letter)
//            }
//            
//        }

        
        setupGoogleSignInButton()
    }
    
    private func setupGoogleSignInButton() {
           let googleSignInButton = GIDSignInButton()
           googleSignInButton.style = .standard
           googleSignInButton.frame = CGRect(x: 0, y: 0, width: 230, height: 50)
           googleSignInButton.center = CGPoint(x: view.center.x, y: view.frame.height - 180)
           googleSignInButton.addTarget(self, action: #selector(googleSignInTapped), for: .touchUpInside)
           view.addSubview(googleSignInButton)
       }
    @objc private func googleSignInTapped() {
            Task {
                do {
                    try await authViewModel.signInGoogle()
                    // Handle successful sign-in (e.g., navigate to the next screen)
                    print("Successfully signed in with Google")
                    performSegue(withIdentifier: K.googleSignInSegue, sender: self)
                    
                    // You can add navigation logic here
                } catch {
                    print("Error signing in with Google: \(error.localizedDescription)")
                    // Handle the error (e.g., show an alert to the user)
                }
            }
        }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
