//
//  TagDAO.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/16.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import Foundation
import Parse
import Alamofire
import SwiftyJSON

class TagDAO{
    
    var parseDelegate : ParseDAODelegate?
    
    var lateralDelegate : LateralDAODelegate?
    
    let query = PFQuery(className: "Tag")
    
    class var sharedInstance: TagDAO {
        
        struct Static {
            
            static var instance: TagDAO?
            static var token: dispatch_once_t = 0
            
        }
        
        dispatch_once(&Static.token) {
            
            Static.instance = TagDAO()
            
        }
        
        return Static.instance!
        
    }
    
    func findAll(){
        
      //  print(PFUser.currentUser())
        
        query.whereKey("user", equalTo:PFUser.currentUser()!)
        
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?) -> Void in
            
            if error != nil{
                
                self.parseDelegate?.findAllError(error!)
                
                print(error)
                
            }else{
                
                var taglist : [TagModel] = []
                
                if let objects = objects as [PFObject]!{
                    
                    for(var i=0;i<objects.count;i++){
                        
                        let tag = TagModel(name:"")
                        
                        tag.name = objects[i].valueForKey("name") as! String
                        
                        taglist.append(tag)
                        
                    }
                    
                    self.parseDelegate?.findAllSuccess(taglist)
                    
                }
                
                
            }
        }

        
        
    }
    
    func create(tag : TagModel){
        
        let tagObject = PFObject(className: "Tag")
        
        tagObject["name"] = tag.name
        
        tagObject["user"] = PFUser.currentUser()!
        
        tagObject.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            
            if success{
                
                self.parseDelegate?.createSuccess()
                
            }else{
                
                self.parseDelegate?.createError(error!)
            }
            
        }
        
    }
    
    func remove(tag : TagModel){
        
        let predicate = NSPredicate(format: "name = '\(tag.name!)'")
        
        let q = PFQuery(className: "Tag", predicate: predicate)
        
        q.whereKey("user", equalTo:PFUser.currentUser()!)
        
        q.findObjectsInBackgroundWithBlock { (tags:[PFObject]?, error:NSError?) -> Void in
            
            if error != nil{
                
                self.parseDelegate?.removeError(error!)
                
            }else{
                
                print(tags?.count)
                
                if let tags = tags as [PFObject]!{
                    
                    for tag in tags{
                        
                        tag.deleteInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                            
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
    
   /* func findAllTagsRecommendedByPapers(papers : [PaperModel]){
        
        var taglist : [String]?
        
        for paper in papers{
            
            let url = "https://document-parser-api.lateral.io/?url=\(paper.url)"
            
            Alamofire.request(.GET, url, parameters:nil, encoding: .JSON, headers:Lateral_Headers)
                
                .responseJSON{ response in
                    
                    if let result = response.result.value{
                        
                        if let data = JSON(rawValue: result){
                            
                            // processing data
                            
                            
                            
                            
                            
                        }else{
                            
                            //json error
                        }
                        
                    }else{
                        
                         self.lateralDelegate?.recommendPapersByTagsError(response.result.error!)
                        
                    }
                    
                    
            }
            
            
        }
    }
    

        */
    
    
}
