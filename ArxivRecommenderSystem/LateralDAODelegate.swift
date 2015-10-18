//
//  LateralDAODelegate.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/16.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import Foundation

protocol LateralDAODelegate{
    
    func recommendPapersByTagsSuccess(result:[AnyObject])
    
    func recommendPapersByTagsError(error:NSError)
    
  //  func recommendTagsByPapersSuccess(result:[AnyObject])
    
  //  func recommendTagsByPapersError(error:NSError)
    
}
