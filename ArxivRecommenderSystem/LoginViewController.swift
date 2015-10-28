//
//  LoginViewController.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/17.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var alertView : DXAlertView?
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        username.delegate = self
        
        password.delegate = self
        
        self.password.secureTextEntry = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func LoginBtn(sender: AnyObject) {
        
        let space = NSCharacterSet.whitespaceAndNewlineCharacterSet()
        
        var UserName = self.username.text
        
        var PassWord = self.password.text
        
        if(UserName!.isEmpty || PassWord!.isEmpty){
            
            self.alertView = DXAlertView.init(title: "Notice", contentText: "No Username or Password", leftButtonTitle: "Type", rightButtonTitle: "Cancel")
            
            self.alertView?.show()
            
        }else{
            
            UserName = UserName!.stringByTrimmingCharactersInSet(space)
            
            PassWord = PassWord!.stringByTrimmingCharactersInSet(space)
            
            PFUser.logInWithUsernameInBackground(UserName!, password: PassWord!) { (user:PFUser?, error:NSError?) -> Void in
                
                if user != nil{
                    
                    self.alertView = DXAlertView.init(title: "Notice", contentText: "Login Successfully", leftButtonTitle: "Ok", rightButtonTitle: "Cancel")
                    
                    self.alertView?.show()
                    
                    NSUserDefaults.standardUserDefaults().setObject(user?.username, forKey: "username")
                    
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                    self.alertView?.leftBlock = {
                        
                        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                        
                        let nav : UINavigationController = mainStoryBoard.instantiateViewControllerWithIdentifier("nav") as! UINavigationController
                        
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        
                        appDelegate.window?.rootViewController = nav
                        
                        self.alertView?.removeFromSuperview()
                        
                    }
                    
                    
                }else{ 
                    
                    self.alertView = DXAlertView.init(title: "Notice", contentText: "Wrong Username or Password", leftButtonTitle: "Retype", rightButtonTitle: "Cancel")
                    
                    self.alertView?.show()
                    
                    
                }
                
            }
 
            
        }
   
    }
    
    @IBAction func RegisterBtn(sender: AnyObject) {
        
        
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    
    
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }

    
    
    
    
    
    

}
