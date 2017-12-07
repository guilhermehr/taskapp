//
//  Post.swift
//  ListaTarefas
//
//  Created by ALOC SP08156 on 06/12/2017.
//  Copyright © 2017 ALOC SP08156. All rights reserved.
//

import Foundation
import EasyRest
import Genome


class Post: BaseModel {
    var id: Int?
    var title: String?
    var body: String?
    
    override func sequence(_ map: Map) throws {
        try id <~> map["id"]
        try title <~> map["title"]
        try body <~> map["body"]
    }
    
}


class Token: BaseModel {
    
    var accessToken: String?
    
    override func sequence(_ map: Map) throws {
        try accessToken <~> map["access_token"]
    }
    
}
