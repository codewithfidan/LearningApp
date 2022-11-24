//
//  UserService.swift
//  LearningApp
//
//  Created by Fidan Oruc on 24.11.22.
//

import Foundation

class UserService{
    
    var user = User()
    
    static var shared = UserService()
    
    private init(){
        
    }
}
