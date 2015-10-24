//
//  ParseDAODelegate.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/16.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import Foundation

protocol ParseDAODelegate {
    
    func findAllSuccess(result:[AnyObject])
    
    func findAllError(error:NSError)
    
    func findOneByTitleSuccess(result:Bool)
    
    func findOneByTitleError(error:NSError)
    
    func updateSuccess()
    
    func updateError(error:NSError)
    
    func createSuccess()
    
    func createError(error:NSError)
    
    func removeSuccess()
    
    func removeError(error:NSError)
    
}
