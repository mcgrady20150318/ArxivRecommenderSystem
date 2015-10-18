//
//  ViewController.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/16.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ParseDAODelegate{
    
    var paper : PaperDAO = PaperDAO()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        paper.parseDelegate = self
        
        let p = PaperModel(title:"xxxxx")
        
        p.author = "bbbb"
        
        p.summary = "xxxxx"
        
        p.time = "adfasfsd"
        
        p.category = "cs"
        
        p.url = "asdfa"
        
    //    paper.createPaper(p)
        
        paper.findAllPapers()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func findAllSuccess(result: [AnyObject]) {
        
        for r in result{
            
            print((r.title))
        }
        
    }
    
    func findAllError(error: NSError) {
        
        
        
    }
    
    func createSuccess() {
        
        print("ok")
        
    }
    
    func createError(error: NSError) {
        
        print(error)
        
    }
    
    func removeSuccess() {
        
    }
    
    func removeError(error: NSError) {
        
    }


}

