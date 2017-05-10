//
//  AppDelegate.swift
//  Youtube
//
//  Created by Doan Tuan on 4/19/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit
import AppAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {
   
    

    var window: UIWindow?
    var currentAuthorizationFlow: OIDAuthorizationFlowSession?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey:Any]?) -> Bool {
       
        // init login
        
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(String(describing: configureError))")
        
        GIDSignIn.sharedInstance().delegate = self
        
        
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        //
        
    }
    
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
//        
//        return GIDSignIn.sharedInstance().handle(url,
//                                                    sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
//                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
//        
//    }
    
    
     func application(app: UIApplication, openURL url: URL, options: [String : AnyObject]) -> Bool {
        // Sends the URL to the current authorization flow (if any) which will process it if it relates to
        // an authorization response.
        
        if currentAuthorizationFlow!.resumeAuthorizationFlow(with: url as URL){
            currentAuthorizationFlow = nil
            return true
        }
        
        // Your additional URL handling (if any) goes here.
        
        return false;
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return self.application(app: application, openURL: url, options: [:])
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

