//
//  RegisterViewController.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/17.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    var alertView : DXAlertView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.delegate = self
        
        passwordField.delegate = self
        
        emailField.delegate = self
        
        passwordField.secureTextEntry = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func RegisterBtn(sender: AnyObject) {
        
        let user = PFUser()
        
        let space = NSCharacterSet.whitespaceAndNewlineCharacterSet()
        
        var username = self.usernameField.text
        
        var password = self.passwordField.text
        
        var email = self.emailField.text
        
        username = username!.stringByTrimmingCharactersInSet(space)
            
        password = password!.stringByTrimmingCharactersInSet(space)
            
        email = email!.stringByTrimmingCharactersInSet(space)
        
        user.username = username
        
        user.password = password
        
        user.email = email
            
        user.signUpInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                
            if success{
                
                NSUserDefaults.standardUserDefaults().setObject(username, forKey: "username")
                
                NSUserDefaults.standardUserDefaults().synchronize()
                
                self.alertView = DXAlertView.init(title: "Notice", contentText: "Congratulations!", leftButtonTitle: "Home", rightButtonTitle: "Cancel")
                
                    
                self.alertView?.show()
                    
                self.alertView?.leftBlock = {
                        
                    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                        
                    let nav : UINavigationController = mainStoryBoard.instantiateViewControllerWithIdentifier("nav") as! UINavigationController
                        
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        
                    appDelegate.window?.rootViewController = nav
                    
                    self.alertView?.removeFromSuperview()
                        
                        
                }
                    
                    
            }else{
                    
                let err = error?.userInfo["error"] as? String
                    
                self.alertView = DXAlertView.init(title: "Notice", contentText: err, leftButtonTitle: "Retype", rightButtonTitle: "Cancel")
                
                self.alertView?.show()
                    
            }
                
        })
                
    }
    
    
    @IBAction func BackToLogin(sender: AnyObject) {
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let login : LoginViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("login") as! LoginViewController
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = login
        
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
            


}
