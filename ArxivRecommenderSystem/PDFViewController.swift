//
//  PDFViewController.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/22.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController,UIWebViewDelegate{
    

    @IBOutlet weak var PDFViewer: UIWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var url : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.PDFViewer.delegate = self
        
        self.setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupUI(){
        
      //  var url = "http://arxiv.org/pdf/1201.4339v1.pdf"
        
        self.PDFViewer.stringByEvaluatingJavaScriptFromString("document.body.style.zoom=0.5")
        
        if let url = url{
            
            print(url)
            
            let pdfurl = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            
            let pdfURL = NSURL(string: pdfurl)!
            
            let urlRequest = NSURLRequest(URL: pdfURL)
            
            PDFViewer.loadRequest(urlRequest)
            
            
        }
        
        
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        
        print("start")
        
        self.indicator.startAnimating()
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        print("finish")
        
        self.indicator.stopAnimating()
        
        self.indicator.hidesWhenStopped = true
    }


}
