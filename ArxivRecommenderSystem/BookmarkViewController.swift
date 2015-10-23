//
//  BookmarkViewController.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/22.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit

class BookmarkViewController: UIViewController,UITableViewDataSource , UITableViewDelegate , PaperDAODelegate,TagDAODelegate{

    @IBOutlet weak var BookmarkPaperTableView: UITableView!
    
    var paperlist : [PaperModel] = []
    
    var paperBL = PaperBL()
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var PaperTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.loadData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* ui init */
    
    
    /* data init */
    
    func loadData(){
        
        self.paperBL.delegate = self
        
        BookmarkPaperTableView.delegate = self
        
        BookmarkPaperTableView.dataSource = self
        
        self.paperBL.findAllPapers()
        
        
    }
    
    
    /* data source */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return self.paperlist.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        self.BookmarkPaperTableView.registerNib(UINib(nibName:"PaperCell",bundle:nil), forCellReuseIdentifier: "PaperCell")
        
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
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        self.paperlist.removeAtIndex(indexPath.row)
        
        self.paperBL.removePaper(self.paperlist[indexPath.row])
        
        self.BookmarkPaperTableView.reloadData()
        
    }
    
    func findAllPapersSuccess(result:[AnyObject]){
        
        self.paperlist = result as! [PaperModel]
        
        self.BookmarkPaperTableView.reloadData()
    
    }
    
    func findAllPapersError(error:NSError){}
    
    
    func removePaperSuccess(){
        
        print("remove paper done!")
        
    }
    
    func removePaperError(error:NSError){}
    

    

    
    
    

    


}
