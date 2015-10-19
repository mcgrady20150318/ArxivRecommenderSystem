//
//  PaperDetailViewController.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/18.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit

class PaperDetailViewController: UIViewController {
    
    var paper = PaperModel(title:"")
    
    @IBOutlet weak var titlename: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var url: UILabel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupUI(){
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"header"), forBarMetrics: UIBarMetrics.Default)
        
        self.titlename.text = self.paper.title
        
        self.author.text = self.paper.author
        
        self.time.text = self.paper.time
        
        self.summary.text = self.paper.summary
        
        self.url.text = self.paper.url
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
