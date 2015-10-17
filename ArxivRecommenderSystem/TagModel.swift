//
//  TagModel.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/16.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import Foundation

class TagModel : NSObject{
    
    var name : String?
    
    var isRecommended : Bool?
    
    var paperid : Int?
    
    init(name : String){
        
        self.name = name
        
    }
}
