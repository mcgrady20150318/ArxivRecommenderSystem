//
//  TagBL.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/17.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import Foundation


class TagBL : ParseDAODelegate,LateralDAODelegate{
    
    var delegate : TagDAODelegate!
    
    func findAllTags(){
        
        let tag = TagDAO.sharedInstance
        
        tag.parseDelegate = self
        
        tag.findAll()
        
    }
    
    func createTag(t:TagModel){
        
        let tag = TagDAO.sharedInstance
        
        tag.parseDelegate = self
        
        tag.create(t)

    }
    
    
    func removeTag(t:TagModel){
        
        let tag = TagDAO.sharedInstance
        
        tag.parseDelegate = self
        
        tag.remove(t)

    }
    
    func recommendTags(paper : PaperModel){
        
        
        let tag = TagDAO.sharedInstance
        
        tag.lateralDelegate = self
        
        tag.findAllTagsRecommendedByPapers(paper)
        
    }
    
    func findAllSuccess(result:[AnyObject]){
        
        self.delegate.findAllTagsSuccess!(result)
        
    }
    
    @objc func findAllError(error:NSError){
        
        self.delegate.findAllTagsError!(error)
        
    }
    
    func createSuccess(){
        
        self.delegate.createTagSuccess!()
        
    }
    
    func createError(error:NSError){
        
        self.delegate.createTagError!(error)
        
    }
    
    func removeSuccess(){
        
        self.delegate.removeTagSuccess!()
        
    }
    
    func removeError(error:NSError){
        
        self.delegate.removeTagError!(error)
        
    }
    
    func recommendPapersByTagsSuccess(result: [AnyObject]) {
        
        
        
    }
    
    func recommendPapersByTagsError(error: NSError) {
        
        
        
    }
    
    func recommendTagsByPapersSuccess(result: [AnyObject]) {
        
        self.delegate.recommendTagsWithPaperSuccess!(result)
        
        
    }
    
    func recommendTagsByPapersError(error: NSError) {
        
        self.delegate.recommendTagsWithPaperError!(error)
        
        
    }
    
    func findOneByTitleSuccess(result:Bool){}
    
    func findOneByTitleError(error:NSError){}
    

    
}