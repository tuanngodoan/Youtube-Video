//
//  LoginGGViewController.swift
//  Youtube
//
//  Created by Doan Tuan on 5/5/17.
//  Copyright © 2017 Doan Tuan. All rights reserved.
//

import UIKit
import Google
import AppAuth

class LoginGGViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var logoutButton:UIButton!
    
    var authState:OIDAuthState!
    var authorizationEndpoint = URL(string: "https://accounts.google.com/o/oauth2/v2/auth")
    var tokenEndpoint = URL(string: "https://www.googleapis.com/oauth2/v4/token")
    var clienID = "1074932922882-n60oujd2sivggm5v835jtudsurir1mtd.apps.googleusercontent.com"
    var redirecURL  = URL(string:"1074932922882-n60oujd2sivggm5v835jtudsurir1mtd.apps.googleusercontent.com://callback")
    var scopes = ["https://www.googleapis.com/auth/youtube","https://www.googleapis.com/auth/youtube.force-ssl","https://www.googleapis.com/auth/youtube.readonly"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        createSignInButton()
        configAuth()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.logoutButton.frame = CGRect(x: 10, y: self.view.frame.height - 200, width: self.view.frame.width - 40, height: 30)
        self.logoutButton.setTitle("Logout", for: .normal)
        self.logoutButton.tintColor = UIColor.black
        self.logoutButton.backgroundColor = UIColor.gray
    }
    
    func configAuth(){
        
        let configuration = OIDServiceConfiguration(authorizationEndpoint: authorizationEndpoint!, tokenEndpoint: tokenEndpoint!)
        
        let request: OIDAuthorizationRequest = OIDAuthorizationRequest(configuration: configuration, clientId: clienID, scopes: scopes, redirectURL: redirecURL!, responseType: OIDResponseTypeCode
            , additionalParameters: nil)
        
        let appDelegte:AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        
        appDelegte?.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: self , callback: { (authState, error) in
           
            if (authState != nil) {
                print("Token = ", authState?.lastTokenResponse?.accessToken as Any)
                self.authState = authState
            }else{
                print("Error", error?.localizedDescription as Any
                )
            }
        })
    }

    
    
    func createSignInButton(){
        
        let signInButton = GIDSignInButton(frame: CGRect(x: 10, y: self.view.frame.height - 270, width: self.view.frame.width - 40, height: 30))
        self.view.addSubview(signInButton)
    }

    @IBAction func TapLogoutButton(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
    }


    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let email = user.profile.email
            
            print("userID: \(String(describing: userId))")
            print("idToken: \(String(describing: idToken))")
            print("email: \(String(describing: email))")
            print("fullName: \(String(describing: fullName))")
            
        } else {
            print("\(error.localizedDescription)")
        }
    }

    
    //
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        
        self.present(viewController, animated: true) {
            
            // when completion
            // Open web signin
        }
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true) { 
            //
        }
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
