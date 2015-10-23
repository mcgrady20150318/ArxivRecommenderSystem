//
//  PaperDetailViewController.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/18.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit

class PaperDetailViewController: UIViewController, PaperDAODelegate,TagDAODelegate{
    
    var paper = PaperModel(title:"")
    
    var paperBL = PaperBL()
    
    var tagBL = TagBL()
    
    @IBOutlet weak var titlename: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var url: UILabel!
    @IBOutlet weak var Like: UIButton!
    
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
        
        paperBL.delegate = self
        
        tagBL.delegate = self
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"header"), forBarMetrics: UIBarMetrics.Default)
        
        self.titlename.text = self.paper.title
        
        self.author.text = self.paper.author
        
        self.time.text = self.paper.time
        
        self.summary.text = self.paper.summary
        
        self.url.text = self.paper.url
        
        if let isLike = self.paper.isLike{
            
            if isLike{
                
                self.Like.setBackgroundImage(UIImage(named: "heartRed"), forState: UIControlState.Normal)
                
                self.Like.alpha = 1.0
                
                
            }else{
                
                self.Like.setBackgroundImage(UIImage(named: "heartWhite"), forState: UIControlState.Normal)
                
                self.Like.alpha = 0.4
                
            }
        }
        
    }
    
    @IBAction func LikeButton(sender: AnyObject) {
        
        self.paperBL.findOnePaperByTitle(paper) // judge the paper is existed in the database
        
        if(self.paper.isLike == false){
            
            self.Like.setBackgroundImage(UIImage(named: "heartRed"), forState: UIControlState.Normal)
            
            self.Like.alpha = 1.0
            
            self.paper.isLike = true
        
            
        }else{
            
            self.Like.setBackgroundImage(UIImage(named: "heartWhite"), forState: UIControlState.Normal)
            
            self.Like.alpha = 0.4
            
            self.paper.isLike = false
          
            self.paperBL.removePaper(paper)
            
        }
        
        
    }
    
    
    @IBAction func ViewPDF(sender: AnyObject) {
        
        //url = "http://arxiv.org/pdf/1201.4339v1.pdf"
        
        //url = "http://arxiv.org/abs/1201.4339"
        
        let id = paper.url!.componentsSeparatedByString("/")[4]
        
        let url = "http://arxiv.org/pdf/\(id)v1.pdf"
        
        let PDFViewer = PDFViewController()
        
        PDFViewer.url = url
        
        self.navigationController?.pushViewController(PDFViewer, animated: true)
        
        
    }
    
    /* delegate */
    
    func findOnePaperByTitleSuccess(result: Bool) {
        
        if result{
            
            print("paper exists!")
            
        }else{
            
            self.paperBL.createPaper(paper)
            
            self.tagBL.recommendTags(paper)
            
        }
    }
    
    func findOnePaperByTitleError(error: NSError) {
        
        print(error)
        
    }
    
    
    func createPaperSuccess(){
        
        print("create paper ok!")
        
    }
    
    func createPaperError(error:NSError){}
    
    func removePaperSuccess(){
        
        print("remove paper ok!")
        
    }
    
    
    func createTagSuccess(){
        
        print("create recommend tag done!")
    
    }
    
    func createTagError(error:NSError){}
    
    func recommendTagsWithPaperSuccess(result:[AnyObject]){
        
        for tag in result{
            
            let t = TagModel(name:(tag as! String))
            
            t.isRecommended = true
            
            self.tagBL.createTag(t)
            
        }
    
    
    }
    
    func recommendTagsWithPaperError(error:NSError){}
    


    

}
