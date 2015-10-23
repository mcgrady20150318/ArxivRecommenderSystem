//
//  TagDAODelegate.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/17.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import Foundation

@objc protocol TagDAODelegate{
    
    optional func findAllTagsSuccess(result:[AnyObject])
    
    optional func findAllTagsError(error:NSError)
    
    optional func createTagSuccess()
    
    optional func createTagError(error:NSError)
    
    optional func removeTagSuccess()
    
    optional func removeTagError(error:NSError)
    
    optional func recommendTagsWithPaperSuccess(result:[AnyObject])
    
    optional func recommendTagsWithPaperError(error:NSError)
    
}