//
//  PaperDAODelegate.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/17.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import Foundation

@objc protocol PaperDAODelegate{
    
    optional func findAllPapersSuccess(result:[AnyObject])
    
    optional func findAllPapersError(error:NSError)
    
    optional func findOnePaperByTitleSuccess(result:Bool)
    
    optional func findOnePaperByTitleError(error:NSError)
    
    optional func createPaperSuccess()
    
    optional func createPaperError(error:NSError)
    
    optional func removePaperSuccess()
    
    optional func removePaperError(error:NSError)
    
    optional func recommendPapersWithTagsSuccess(result:[AnyObject])
    
    optional func recommendPapersWithTagsError(error:NSError)


}