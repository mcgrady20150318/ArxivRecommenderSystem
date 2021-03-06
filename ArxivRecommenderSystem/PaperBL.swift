//
//  PaperBL.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/17.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import Foundation
import Parse

class PaperBL : ParseDAODelegate,LateralDAODelegate{
    
    var delegate : PaperDAODelegate!
    
    func findAllPapers(){
        
        let paper = PaperDAO.sharedInstance
        
        paper.parseDelegate = self
        
        paper.findAll()
        
    }
    
    func findOnePaperByTitle(p:PaperModel){
        
        let paper = PaperDAO.sharedInstance
        
        paper.parseDelegate = self
        
        paper.findOneByTitle(p)
        
    }

    
    func createPaper(p:PaperModel){
        
        let paper = PaperDAO.sharedInstance
        
        paper.parseDelegate = self
        
        paper.create(p)
        
    }
    
    func updatePaper(p:PaperModel){
        
        let paper = PaperDAO.sharedInstance
        
        paper.parseDelegate = self
        
        paper.update(p)
        
    }
    
    func removePaper(p:PaperModel){
        
        let paper = PaperDAO.sharedInstance
        
        paper.parseDelegate = self
        
        paper.remove(p)
        
    }
    
    func recommendPaper(tags:[TagModel]){
        
        
        let paper = PaperDAO.sharedInstance
        
        paper.lateralDelegate = self
        
        paper.findAllPapersRecommendedByTags(tags)
        
    }
    
    func findAllSuccess(result:[AnyObject]){
        
        self.delegate.findAllPapersSuccess!(result)
    
    }
    
    func findAllError(error:NSError){
    
        self.delegate.findAllPapersError!(error)
        
    }
    
    func findOneByTitleSuccess(result:Bool){
        
        self.delegate.findOnePaperByTitleSuccess!(result)
        
    }
    
    func findOneByTitleError(error:NSError){
        
        self.delegate.findOnePaperByTitleError!(error)
        
    }
    
    func createSuccess(){
        
        self.delegate.createPaperSuccess!()
    
    }
    
    func createError(error:NSError){
        
        self.delegate.createPaperError!(error)
    
    }
    
    func updateSuccess() {
        
        self.delegate.updatePaperSuccess!()
    }
    
    func updateError(error: NSError) {
        
        self.delegate.updatePaperError!(error)
        
    }
    
    func removeSuccess(){
    
        self.delegate.removePaperSuccess!()
    
    }
    
    func removeError(error:NSError){
        
        self.delegate.removePaperError!(error)
    
    }
    
    func recommendPapersByTagsSuccess(result: [AnyObject]) {
        
        self.delegate.recommendPapersWithTagsSuccess!(result)
        
    }
    
    func recommendPapersByTagsError(error: NSError) {
        
        self.delegate.recommendPapersWithTagsError!(error)
        
    }
    
    func recommendTagsByPapersSuccess(result: [AnyObject]) {
        
        
    }
    
    func recommendTagsByPapersError(error: NSError) {
        
        
    }
    
    
}
