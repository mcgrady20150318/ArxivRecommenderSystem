//
//  const.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/17.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import Foundation


let Lateral_API_KEY = "925238b9ec66cb7e4b2d28e1078c2d51"

let Lateral_Headers = [
    
    "content-type" : "application/json",
    "subscription-key" : Lateral_API_KEY
    
]

enum Err : String{
    
    case JSONUnserialization = "JSON Unserialization error"
    
    
}

