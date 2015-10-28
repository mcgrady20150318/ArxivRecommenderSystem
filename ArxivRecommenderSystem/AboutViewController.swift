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

    @IBOutlet weak var adView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ca-app-pub-7417238904018690/1213249969
        self.setupAd()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAd(){
        
        self.adView.adUnitID = "ca-app-pub-7417238904018690/1213249969"
        
        self.adView.rootViewController = self
        
        self.adView.loadRequest(GADRequest())
        
        
    }
    

}
