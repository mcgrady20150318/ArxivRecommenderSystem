//
//  PaperDAODelegate.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/17.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import Foundation

protocol PaperDAODelegate{
    
    func findAllPapersSuccess(result:[AnyObject])
    
    func findAllPapersError(error:NSError)
    
    func createPaperSuccess()
    
    func createPaperError(error:NSError)
    
    func removePaperSuccess()
    
    func removePaperError(error:NSError)
    
    func recommendPapersWithTagsSuccess(result:[AnyObject])
    
    func recommendPapersWithTagsError(error:NSError)


}