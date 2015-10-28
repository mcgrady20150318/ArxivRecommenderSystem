//
//  AppDelegate.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/16.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit
import Parse
import Bolts



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var introductionView: ZWIntroductionViewController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Parse.enableLocalDatastore()
        
        Parse.setApplicationId("cLglfxuMeIi0f28SKdKksJF5fJfMcKrWIy7iIooC", clientKey: "g8y2qzYiPvjbY8fcO5kQp93LdRi8wWNObtBu3iZ6")
        
      /*  let isIntro : String? = NSUserDefaults.standardUserDefaults().stringForKey("intro")
        
        if isIntro == nil{
            
            let backgroundImageNames = ["intro1","intro2", "intro3"]
            self.introductionView = ZWIntroductionViewController(coverImageNames: ["","",""], backgroundImageNames: backgroundImageNames)
            
            NSUserDefaults.standardUserDefaults().setObject("1", forKey: "intro")
            
            NSUserDefaults.standardUserDefaults().synchronize()
            
            self.window?.rootViewController = self.introductionView
            
            self.introductionView!.didSelectedEnter = {
                
                self.introductionView!.view.removeFromSuperview()
                self.introductionView = nil;
                
                self.Enter()
                
            }
            
        }else{
            
            Enter()
            
            
        }*/
        
        Enter()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func Enter(){
        
        let username : String? = NSUserDefaults.standardUserDefaults().stringForKey("username")
        
        if username != nil{
            
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            
            let nav : UINavigationController = mainStoryBoard.instantiateViewControllerWithIdentifier("nav") as! UINavigationController
            
            self.window?.rootViewController = nav
            
        }else{
            
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            
            let login : LoginViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("login") as! LoginViewController
            
            self.window?.rootViewController = login
            
            
        }

        
    }


}

