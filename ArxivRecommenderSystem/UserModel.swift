//
//  UserModel.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/16.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import Foundation


class UserModel : NSObject{
    
    var username : String?
    
    var password : String?{
        
        return self.password
    }
    
    var email : String?
    
    var avatar : String?
    
    init(username : String){
        
        self.username = username
        
    }
    
}
