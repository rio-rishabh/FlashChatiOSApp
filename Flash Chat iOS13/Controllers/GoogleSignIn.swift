//
//  GoogleSignIn.swift
//  Flash Chat iOS13
//
//  Created by Rishabh Sharma on 30/07/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

@MainActor
 final class AuthenticationViewModel : ObservableObject{
    
    func signInGoogle() async throws{
        guard let topVC = Utilities.shared.topViewController() else{
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
//        GIDSignInResult.user

        guard let idToken = gidSignInResult.user.idToken?.tokenString else{
            throw URLError(.badServerResponse)
        }
        let accessToken = gidSignInResult.user.accessToken.tokenString
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        let result = try await Auth.auth().signIn(with: credential)
        
        let firebaseUser = result.user
        print("user\(firebaseUser.uid)signed in with email\(firebaseUser.email ?? "unknown")")
    }
}
