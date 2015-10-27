//
//  PaperViewController.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/18.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit

class PapersViewController: UIViewController, UITableViewDataSource , UITableViewDelegate , PaperDAODelegate,TagDAODelegate{
    
    var paperlist : [PaperModel] = []
    
    var paperBL = PaperBL()
    
    var tagBL = TagBL()
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var PaperTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.loadData()
        
        self.setupUI()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* ui init */
    
    func setupUI(){
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"header"), forBarMetrics: UIBarMetrics.Default)
        
        self.indicator.startAnimating()
        
        
    }
    
    /* data init */
    
    func loadData(){
        
        self.paperBL.delegate = self
        
        self.tagBL.delegate = self
        
        PaperTableView.delegate = self
        
        PaperTableView.dataSource = self
        
        self.tagBL.findAllTags()
        
    }
    
    
    @IBAction func ReturnToHome(sender: AnyObject) {
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let nav : UINavigationController = mainStoryBoard.instantiateViewControllerWithIdentifier("nav") as! UINavigationController
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = nav
        
        
    }
    
    /* data source */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return self.paperlist.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        self.PaperTableView.registerNib(UINib(nibName:"PaperCell",bundle:nil), forCellReuseIdentifier: "PaperCell")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PaperCell") as! PaperCell
        
        let paper = self.paperlist[indexPath.row] as PaperModel!
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            cell.setupUI(paper)
            
        }
        
        return cell
        
    }
  
    
    /* delegate */
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        return 240
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return 10.0
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        
        return 10.0
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        let paperdetailVC = PaperDetailViewController(nibName: "PaperDetailViewController", bundle: nil)
        
        paperdetailVC.paper = self.paperlist[indexPath.row]
        
        
        self.navigationController?.pushViewController(paperdetailVC, animated: true)
        
    }
    
    func findAllPapersSuccess(result:[AnyObject]){}
    
    func findAllPapersError(error:NSError){}
    
    func createPaperSuccess(){
        
        print("create paper done!")
    
    }
    
    func createPaperError(error:NSError){}
    
    func removePaperSuccess(){
    
        print("remove paper done!")
        
    }
    
    func removePaperError(error:NSError){}
    
    func recommendPapersWithTagsSuccess(result:[AnyObject]){
        
        self.paperlist = result as! [PaperModel]
        
        self.PaperTableView.reloadData()
        
        self.indicator.stopAnimating()
        
        self.indicator.hidesWhenStopped = true
        
        print("recommend papers ok!")
        
    }
    
    func recommendPapersWithTagsError(error:NSError){}
    
    func findAllTagsSuccess(result:[AnyObject]){
        
        paperBL.recommendPaper(result as! [TagModel])
        
        print("find all tags")
        
    }
    
 
    
    
    
}
