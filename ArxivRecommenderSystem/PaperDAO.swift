//
//  PaperDAO.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/16.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import Foundation
import Parse
import Alamofire
import SwiftyJSON

class PaperDAO{
    
    var parseDelegate : ParseDAODelegate?
    
    var lateralDelegate : LateralDAODelegate?
    
    let query = PFQuery(className: "Paper")
    
    init(){
        
        PFUser.logInWithUsernameInBackground("Ring", password:"zhangjun164") {
            
            (user: PFUser?, error: NSError?) -> Void in
            
            if user != nil {
                
                print(PFUser.currentUser()?.objectId)
                
            }else{
                
                
            }
        }
        
    }
    
    func findAllPapers(){
        
        query.whereKey("user", equalTo:(PFUser.currentUser())!)
        
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?) -> Void in
                    
            if error != nil{
                        
                self.parseDelegate?.findAllError(error!)
                
                print(error)
                        
            }else{
                        
                var paperlist : [PaperModel] = []
                        
                if let objects = objects as [PFObject]!{
                    
                  //  print(objects.count)
                            
                    for(var i=0;i<objects.count;i++){
                                
                        let paper = PaperModel(title:"")
                                
                        paper.title = objects[i].valueForKey("title") as? String
                                
                        paper.author = objects[i].valueForKey("author") as? String
                                
                        paper.summary = objects[i].valueForKey("summary") as? String
                                
                        paper.category = objects[i].valueForKey("category") as? String
                                
                        paper.time = objects[i].valueForKey("time") as? String
                                
                        paper.url = objects[i].valueForKey("url") as? String
                                
                        paperlist.append(paper)
                                
                    }
                            
                    self.parseDelegate?.findAllSuccess(paperlist)
                            
                }
                        
                        
            }
        }
        

    }
    
    func createPaper(paper : PaperModel){
        
        let paperObject = PFObject(className: "Paper")
        
        paperObject["title"] = paper.title
        
        paperObject["author"] = paper.author
        
        paperObject["category"] = paper.category
        
        paperObject["summary"] = paper.summary
        
        paperObject["time"] = paper.time
        
        paperObject["url"] = paper.url
        
        print(PFUser.currentUser())
        
        paperObject["user"] = (PFUser.currentUser())!
        
        paperObject.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            
            if success{
                
                self.parseDelegate?.createSuccess()
                
            }else{
                
                self.parseDelegate?.createError(error!)
            }
            
        }
        
    }
    
    func removePaper(paper : PaperModel){
        
        let predicate = NSPredicate(format:"title=\(paper.title) and user=\(PFUser.currentUser())")
        
        let q = PFQuery(className: "Paper", predicate: predicate)
        
        q.findObjectsInBackgroundWithBlock { (papers:[PFObject]?, error:NSError?) -> Void in
            
            if error != nil{
                
                self.parseDelegate?.removeError(error!)
                
            }else{
                
                if let papers = papers as [PFObject]!{
                    
                    for paper in papers{
                        
                        paper.deleteInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                            
                            if success{
                                
                                self.parseDelegate?.removeSuccess()
                                
                            }else{
                                
                                self.parseDelegate?.removeError(error!)
                                
                            }
                            
                            
                        })
                    }
                    
                    
                    
                }
                
            }
            
        }
        
        
    }
    
    func findAllPapersRecommendedByTags(tags : [TagModel]){
        
        var paperlist : [PaperModel]?
        
        var str = ""
            
        for tag in tags{
            
            str.appendContentsOf(" ")
            
            if let name = tag.name{
                
                str.appendContentsOf(name)
                
            }
            
        }
        
        let url = "https://arxiv-api.lateral.io/recommend-by-text/"
        
        let parameters = [
            
            "text" : str
            //"Machine learning is a subfield of computer science that evolved from the study of pattern recognition"
        ]
        
        Alamofire.request(.POST, url, parameters:parameters, encoding: .JSON, headers:Lateral_Headers)
        
            .responseJSON{ response in
                
                if let result = response.result.value{
                    
                    if let data = JSON(rawValue: result){
                        
                        for d in data{
                            
                            // json value error handle
                            
                            let paper = PaperModel(title: "")
                            
                            paper.title = d.1["title"].stringValue
                            
                            paper.author = d.1["authors"][0].stringValue
                            
                            paper.summary = d.1["text"].stringValue
                            
                            paper.time = d.1["date"].stringValue
                            
                          //  paper.category = d.1["category"].stringValue
                            
                            paper.url = d.1["url"].stringValue
                            
                            paperlist?.append(paper)
                            
                            
                        }
                        
                        self.lateralDelegate?.recommendPapersByTagsSuccess(paperlist!)
                        
                        
                    }else{
                        
                        //json error
                        
                        
                        //let error = NSError(domain: "PaperDAO", code: 400, userInfo: [Err.JSONUnserialization])
                        
                       // self.lateralDelegate?.recommendPapersByTagsError()
                        
                        
                    }
                    
                    
                    
                    
                }else{
                    
                    self.lateralDelegate?.recommendPapersByTagsError(response.result.error!)
                    
                }
                
                
                
        }
        
    }
    

    
    
}
