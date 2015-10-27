//
//  PaperDetailViewController.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/18.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit
import Alamofire
import AFMInfoBanner

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
    @IBOutlet weak var PDF: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
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
        
        self.indicator.hidden = true
        
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
                
                if self.paper.isDownload == true{
                    
                    self.PDF.setTitle("View PDF", forState: UIControlState.Normal)
                    
                }else{
                    
                    self.PDF.setTitle("Download PDF", forState: UIControlState.Normal)
                }
                
            }else{
                
                self.Like.setBackgroundImage(UIImage(named: "heartWhite"), forState: UIControlState.Normal)
                
                self.Like.alpha = 0.4
                
            }
        }else{
            
            self.PDF.hidden = true
            
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
        
        //download pdf first
        
        let id = paper.url!.componentsSeparatedByString("/")[4]
        
        let url = "http://arxiv.org/pdf/\(id).pdf"
        
        if self.paper.isDownload == false{
            
            //download
            
            self.indicator.hidden = false
            
            self.indicator.startAnimating()
            
            Alamofire.download(.GET, url) { temporaryURL, response in
                
                let fileManager = NSFileManager.defaultManager()
                let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
                
                //button = "view pdf"
                
                return directoryURL.URLByAppendingPathComponent("\(id).pdf")
                
                }.progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                    print(totalBytesRead)
                    
                    // This closure is NOT called on the main queue for performance
                    // reasons. To update your ui, dispatch to the main queue.
                    dispatch_async(dispatch_get_main_queue()) {
                        print("Total bytes read on main queue: \(totalBytesRead)")
                    }
                    
                   
                }.response { _, _, _, error in
                    if let error = error {
                        print("Failed with error: \(error)")
                    } else {
                        print("Downloaded file successfully")
                        
                        self.indicator.stopAnimating()
                        
                        self.indicator.hidesWhenStopped = true
                        
                        self.PDF.setTitle("View PDF", forState: UIControlState.Normal)
                        
                        AFMInfoBanner.showAndHideWithText("Paper Download Successfully", style: AFMInfoBannerStyle.Info)
                    
                        //update database paper file
                        
                        self.paperBL.updatePaper(self.paper)
                        
                        self.paper.isDownload = true
                    }
            }
            
            
            
            
        }else{
            
            //view 
            
            print("view pdf")
            
            let manager = NSFileManager.defaultManager()
            
            var path = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
            
            path = path.URLByAppendingPathComponent("\(id).pdf")
            
            let PDFViewer = PDFViewController()
                
            PDFViewer.url = path
                
            self.navigationController?.pushViewController(PDFViewer, animated: true)
        
        }
        
        
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
    
    func updatePaperSuccess() {
        
        print("download ok and update parse database ok")
    }
    
    func updatePaperError(error: NSError) {
        
        
    }
    
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
