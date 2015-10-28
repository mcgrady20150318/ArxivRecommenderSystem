//
//  AboutViewController.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/27.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AboutViewController: UIViewController{

    
    @IBOutlet weak var intro: UITextView!
    @IBOutlet weak var adView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ca-app-pub-7417238904018690/1213249969
        self.setupUI()
        self.setupAd()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI(){
        
        self.intro.text = "ArxivRS is a tool for researchers who use arxiv. It aims to help researchers to find interested papers and tags easily. We recommend papers from your tags edited in the home page, and recommend tags from your bookmarked papers.It is an iterative progress to train your personal recommender. If you have any questions or suggestions when use it, please let me know."
        
        
    }
    
    func setupAd(){
        
        self.adView.adUnitID = "ca-app-pub-7417238904018690/1213249969"
        
        self.adView.rootViewController = self
        
        self.adView.loadRequest(GADRequest())
        
        
    }
    

}
