//
//  TagBL.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/17.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import Foundation


class TagBL : ParseDAODelegate{
    
    var delegate : TagDAODelegate?
    
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
    
    func findAllSuccess(result:[AnyObject]){
        
        self.delegate?.findAllTagsSuccess(result)
        
    }
    
    func findAllError(error:NSError){
        
        self.delegate?.findAllTagsError(error)
        
    }
    
    func createSuccess(){
        
        self.delegate?.createTagSuccess()
        
    }
    
    func createError(error:NSError){
        
        self.delegate?.createTagError(error)
        
    }
    
    func removeSuccess(){
        
        self.delegate?.removeTagSuccess()
        
    }
    
    func removeError(error:NSError){
        
        self.delegate?.removeTagError(error)
        
    }
    

    
}