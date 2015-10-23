//
//  ViewController.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/16.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController,PaperDAODelegate,TagDAODelegate{
    
    var paper = PaperBL()
    
    var tag = TagBL()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        paper.delegate = self
        
        tag.delegate = self
        
        tag.findAllTags()
        
      //  paper.removePaper(p)
        
      //  paper.createPaper(p)
        
     //   paper.findAllPapers()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  



}

