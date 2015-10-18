//
//  TagDAODelegate.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/17.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import Foundation

protocol TagDAODelegate{
    
    func findAllTagsSuccess(result:[AnyObject])
    
    func findAllTagsError(error:NSError)
    
    func createTagSuccess()
    
    func createTagError(error:NSError)
    
    func removeTagSuccess()
    
    func removeTagError(error:NSError)
    
}