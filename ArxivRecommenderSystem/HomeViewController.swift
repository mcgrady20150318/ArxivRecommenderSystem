//
//  HomeViewController.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/17.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit
import Parse

class HomeViewController : UIViewController,TagDAODelegate,UITextFieldDelegate{
    
    var TagObject = TagBL()
    
    var tags : [String] = []
    
    var alertView : DXAlertView?
    
    var indicatorView : MONActivityIndicatorView?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tagListView: AMTagListView!
    @IBOutlet weak var PaperButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
        
        self.setupUI()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* ui init */
    
    func setupUI(){
        
        self.indicatorView = MONActivityIndicatorView.init(frame: CGRectMake(120, 300, 50, 50))
        
        self.view.addSubview(self.indicatorView!)
        
        self.indicatorView?.startAnimating()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"header"), forBarMetrics: UIBarMetrics.Default)
        
        self.PaperButton.hidden = true
        
        textField.layer.borderColor = UIColor(red:0.12, green:0.25, blue:0.84, alpha:1).CGColor
        textField.layer.borderWidth = 2.0
        textField.delegate = self
        AMTagView.appearance().tagLength = 10
        AMTagView.appearance().textFont = UIFont(name: "Futura", size: 14)
        AMTagView.appearance().tagColor = UIColor(red:0.12, green:0.55, blue:0.84, alpha:1)
        
        self.alertView = DXAlertView.init(title: "Delete", contentText: "Delete this tag?", leftButtonTitle: "ok", rightButtonTitle: "cancel")
        
        tagListView.setTapHandler { (view : AMTagView?) -> Void in
            
            
            self.alertView?.show()
            
            self.alertView?.leftBlock = {
                
                //remove tag from Parse
                
                self.tagListView.removeTag(view!)
                
                self.TagObject.removeTag(TagModel(name:(view?.tagText())!))
                
            }
            
            
        }
        
  
    }
    
    
    /* data init */
    
    func loadData(){
        
        self.TagObject.delegate = self
        
        textField.delegate = self
        
        self.TagObject.findAllTags()
        
    }
    
    /* Action */
    
    @IBAction func GotoPaperViewController(sender: AnyObject) {
        
        let paperVC = PapersViewController(nibName: "PapersViewController", bundle: nil)
        
        self.navigationController?.pushViewController(paperVC, animated: true)

    }
    
    
    /* delegate implement */
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        tagListView.addTag(textField.text)
        
        //create tag to Parse
        
        self.TagObject.createTag(TagModel(name:textField.text!))
        
        textField.text = ""
        
        return false
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        textField.resignFirstResponder()
        
    }
    
    
    func findAllTagsSuccess(result: [AnyObject]) {
        
        let tags = result as! [TagModel]
        
        for tag in tags{
            
            self.tags.append(tag.name!)
        }
        
        tagListView.addTags(self.tags)
        
        self.PaperButton.hidden = false
        
        self.indicatorView?.stopAnimating()
        
    }
    
    func findAllTagsError(error: NSError) {
        
        print(error)
        
    }
    
    func createTagSuccess() {
        
        print("create ok!")
        
        
    }
    
    func createTagError(error: NSError) {
        
        
    }
    
    func removeTagSuccess() {
        
        print("remove ok!")
        
        
    }
    
    func removeTagError(error: NSError) {
        
        
    }
    
    
    
    
    
}

