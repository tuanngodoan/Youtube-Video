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

class LoginGGViewController: UIViewController, GIDSignInUIDelegate, OIDAuthStateChangeDelegate, OIDAuthStateErrorDelegate {

    @IBOutlet weak var logoutButton:UIButton!
    
    let kIssuer = "https://accounts.google.com"
    
    var authState:OIDAuthState!
    
    var clienID = "1074932922882-n60oujd2sivggm5v835jtudsurir1mtd.apps.googleusercontent.com"
    
    var redirecURL  = "com.googleusercontent.apps.1074932922882-n60oujd2sivggm5v835jtudsurir1mtd:/oauthredirect"
    
    let kAppAuthExampleAuthStateKey = "authState";
    
    //"https://www.googleapis.com/auth/youtube","https://www.googleapis.com/auth/youtube.force-ssl","https://www.googleapis.com/auth/youtube.readonly",
    var scopes = ["https://www.googleapis.com/auth/youtube","https://www.googleapis.com/auth/youtube.force-ssl","https://www.googleapis.com/auth/youtube.readonly",OIDScopeOpenID,OIDScopeProfile]

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //GIDSignIn.sharedInstance().uiDelegate = self
        //createSignInButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.logoutButton.frame = CGRect(x: 10, y: self.view.frame.height - 200, width: self.view.frame.width - 40, height: 30)
        self.logoutButton.setTitle("Login with Youtube/Google Account", for: .normal)
        self.logoutButton.tintColor = UIColor.white
        self.logoutButton.backgroundColor = UIColor.red
    }

    func createSignInButton(){
        
        let signInButton = GIDSignInButton(frame: CGRect(x: 10, y: self.view.frame.height - 270, width: self.view.frame.width - 40, height: 30))
        self.view.addSubview(signInButton)
    }

    @IBAction func TapLogoutButton(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        autoWithAutoCodeExchange()
    }
    
    func saveState(){
        // for production usage consider using the OS Keychain instead
        if authState != nil{
            let archivedAuthState = NSKeyedArchiver.archivedData(withRootObject: authState!)
            UserDefaults.standard.set(archivedAuthState, forKey: kAppAuthExampleAuthStateKey)
        }
        else{
            UserDefaults.standard.set(nil, forKey: kAppAuthExampleAuthStateKey)
        }
        UserDefaults.standard.synchronize()
    }
    
    /*! @fn loadState
     @brief Loads the @c OIDAuthState from @c NSUSerDefaults.
     */
    func loadState(){
        // loads OIDAuthState from NSUSerDefaults
        guard let archivedAuthState = UserDefaults.standard.object(forKey: kAppAuthExampleAuthStateKey) as? Data else{
            return
        }
        guard let authState = NSKeyedUnarchiver.unarchiveObject(with: archivedAuthState) as? OIDAuthState else{
            return
        }
        assignAuthState(authState)
    }
    
    func assignAuthState(_ authState:OIDAuthState?){
        self.authState = authState
        self.authState?.stateChangeDelegate = self as? OIDAuthStateChangeDelegate
        self.stateChanged()
    }
    
    func updateUI(){
        // dynamically changes authorize button text depending on authorized state
        if authState != nil {
        }
        else{
        }
    }
    
    func stateChanged(){
        self.saveState()
        self.updateUI()
    }
    
    
    func didChange(_ state: OIDAuthState) {
        authState = state
        authState?.stateChangeDelegate = self as? OIDAuthStateChangeDelegate
        self.stateChanged()
    }
    
    func autoWithAutoCodeExchange() {
        let issuer = URL(string: kIssuer)
        let redirectURI = URL(string: redirecURL)
        
        print("issuer: \(issuer!)")
        
        // discovers endpoints
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer!){
            configuration,error in
            
            if configuration == nil {
               print("Error : \(String(describing: error?.localizedDescription))")
                self.assignAuthState(nil)
                return
            }
            
            print("Got configuration: \(configuration!)")
            
            // builds authentication request
            let request = OIDAuthorizationRequest(configuration: configuration!,
                                                  clientId: self.clienID,
                                                  scopes: /*[OIDScopeOpenID,OIDScopeProfile]*/self.scopes,
                                                  redirectURL: redirectURI!, responseType: OIDResponseTypeCode,
                                                  additionalParameters: nil)
            
            // performs authentication request
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
           print(" request with scope: \(request.scope!)")
            
            appDelegate.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: self){
                authState,error in
                if authState != nil{
                    self.assignAuthState(authState)
                    print("Access token: \(authState!.lastTokenResponse!.accessToken!)")
                    ConstanAPI.access_tokenKey = authState!.lastTokenResponse!.accessToken!
                }
                else{
                    print("Authorization error: \(error!.localizedDescription)")
                    self.assignAuthState(nil)
                }
            }
        }
    }
    
    func clearAuthState() {
        self.assignAuthState(nil)
    }
    
    func authState(_ state: OIDAuthState, didEncounterAuthorizationError error: Error) {
        print(state.lastTokenResponse?.accessToken as Any)
    }
}
