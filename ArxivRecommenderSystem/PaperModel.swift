//
//  PaperModel.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/16.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import Foundation

class PaperModel : NSObject{
    
    var title : String?
    
    var author : String?
    
    var summary : String?
    
    var category : String?
    
    var time : String?
    
    var url : String?
    
    var userid : Int?
    
    var isLike : Bool?
    
    var isDownload : Bool?
    
    init(title : String){
        
        self.title = title
        
    }
}
