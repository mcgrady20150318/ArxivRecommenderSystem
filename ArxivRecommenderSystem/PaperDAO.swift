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
    
    var parseDelegate : ParseDAODelegate!
    
    var lateralDelegate : LateralDAODelegate!
    
    class var sharedInstance: PaperDAO {
        
        struct Static {
            
            static var instance: PaperDAO?
            static var token: dispatch_once_t = 0
            
        }
        
        dispatch_once(&Static.token) {
            
            Static.instance = PaperDAO()
            
        }
        
        return Static.instance!
        
    }
    
    func findAll(){
        
      //  print((PFUser.currentUser()?.sessionToken)!)
        let query = PFQuery(className: "Paper")
        
        query.fromLocalDatastore()
        
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?) -> Void in
                    
            if error != nil{
                        
                self.parseDelegate.findAllError(error!)
            
                        
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
                        
                        paper.isLike = objects[i].valueForKey("isLike") as? Bool
                        
                        paper.isDownload = objects[i].valueForKey("isDownload") as? Bool
                        
                     //   print(paper.file)
                                
                        paperlist.append(paper)
                                
                    }
                    
                    self.parseDelegate.findAllSuccess(paperlist)
                    
                    
                }
                        
                        
            }
        }
        

    }
    
    func findOneByTitle(paper : PaperModel){
        
        let query = PFQuery(className: "Paper")
        
        query.fromLocalDatastore()
        
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        
        query.whereKey("title", equalTo: paper.title!)
        
        query.findObjectsInBackgroundWithBlock { (papers:[PFObject]?, error:NSError?) -> Void in
            
            if error == nil{
                
                if papers?.count > 0{
                    
                    self.parseDelegate.findOneByTitleSuccess(true)
                    
                }else{
                    
                    self.parseDelegate.findOneByTitleSuccess(false)
                }
                
                
            }else{
                
                self.parseDelegate.findOneByTitleError(error!)
            }
            
        }
        
    }
    
    func update(paper : PaperModel){
        
        //update isDownload
        
        let query = PFQuery(className: "Paper")
        
        query.fromLocalDatastore()
        
        query.whereKey("title", equalTo: paper.title!)
        
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?) -> Void in
            
            if error == nil{
                
                if let objects = objects{
                    
                    for object in objects{
                        
                        object["isDownload"] = true
                        
                        object.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                            
                            if(error == nil){
                                
                                self.parseDelegate.updateSuccess()
                                
                                object.saveEventually()
                                
                            }else{
                                
                                self.parseDelegate.updateError(error!)
                            }
  

                        })
                        
                        
                    }
                    
                    
                }
  
                
            }else{
                
                self.parseDelegate.updateError(error!)
            }
            
        }
        
    }
    
    func create(paper : PaperModel){
        
        let paperObject = PFObject(className: "Paper")
        
        paperObject["title"] = paper.title
        
        paperObject["author"] = paper.author
        
    //    paperObject["category"] = paper.category
        
        paperObject["summary"] = paper.summary
        
        paperObject["time"] = paper.time
        
        paperObject["url"] = paper.url
        
        paperObject["isLike"] = true
        
        paperObject["isDownload"] = false
        
    //    print(PFUser.currentUser())
        
        paperObject["user"] = (PFUser.currentUser()!)
        
        paperObject.pinInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            
            if success{
                
                self.parseDelegate.createSuccess()
                
            }else{
                
                self.parseDelegate.createError(error!)
            }
            
        }
        
        paperObject.saveEventually()
        
        /*paperObject.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            
            if success{
                
                self.parseDelegate.createSuccess()
                
            }else{
                
                self.parseDelegate.createError(error!)
            }
            
        }*/
        
    }
    
    func remove(Paper : PaperModel){
        
        let predicate = NSPredicate(format:"title='\((Paper.title)!)'")
        
        let query = PFQuery(className: "Paper", predicate: predicate)
        
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        
        query.findObjectsInBackgroundWithBlock { (papers:[PFObject]?, error:NSError?) -> Void in
            
            if error != nil{
                
                self.parseDelegate.removeError(error!)
                
            }else{
                
                if let papers = papers as [PFObject]!{
                    
                    for paper in papers{
                        
                        paper.unpinInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                            
                            if success{
                                
                                self.parseDelegate.removeSuccess()
                                
                            }else{
                                
                                self.parseDelegate.removeError(error!)
                            }
                        
                        })
                        
                        paper.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                            
                            paper.deleteInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                                
                                if success{
                                    
                                    self.parseDelegate.removeSuccess()
                                    
                                }else{
                                    
                                    self.parseDelegate.removeError(error!)
                                    
                                }
                                
                                
                            })
                            
                            
                        })
                        
                        
                    }
                    
                    
                    
                }
                
            }
            
        }
        
        
    }
    
    func findAllPapersRecommendedByTags(tags : [TagModel]){
        
        var paperlist : [PaperModel] = []
        
        var str = ""
            
        for tag in tags{
            
            str  += " "
            
            if let name = tag.name{
                
                str += name
                
            }
            
        }
        
     //   print(str)
        
        let url = "https://arxiv-api.lateral.io/recommend-by-text/"
        
        let parameters = [
            
            "text" : str
            //"Machine learning is a subfield of computer science that evolved from the study of pattern recognition"
        ]
        

        Alamofire.request(.POST, url, parameters:parameters, encoding: .JSON, headers:Lateral_Headers)
        
            .responseJSON{ response in
                
                if let result = response.result.value{
                    
                    if let data = JSON(rawValue: result){
                        
                     //   print(data)
                        
                        for(var i=0;i<data.count;i++){
                            
                            let paper = PaperModel(title: "")
                            
                            paper.title = data[i]["title"].stringValue
                            
                            paper.author = data[i]["authors"][0].stringValue
                            
                            paper.summary = data[i]["text"].stringValue
                            
                            paper.time = data[i]["date"].stringValue
                            
                            //  paper.category = d.1["category"].stringValue
                            
                            paper.url = data[i]["url"].stringValue
                            
                            paper.isLike = false
                            
                       //     print(paper.title)
                            
                            paperlist.append(paper)
                            
                        }
                        
                        
                        self.lateralDelegate.recommendPapersByTagsSuccess(paperlist)
                        
                        
                    }else{
                        
                        //json error
                        
                        
                        //let error = NSError(domain: "PaperDAO", code: 400, userInfo: [Err.JSONUnserialization])
                        
                       // self.lateralDelegate?.recommendPapersByTagsError()
                        
                        
                    }
                    
                    
                    
                    
                }else{
                    
                    self.lateralDelegate.recommendPapersByTagsError(response.result.error!)
                    
                }
                
                
                
        }
        
    }
    

    
    
}
