//
//  GetService.swift
//  taskapp
//
//  Created by Guilherme on 07/12/2017.
//  Copyright © 2017 Guilherme. All rights reserved.
//

import Foundation

import Foundation
import EasyRest
import Genome


class Tasks: BaseModel {
    
    var count: Int?
    var next: Int?
    var previous: Int?
    var results: [TaskItem]?
    
    override func sequence(_ map: Map) throws {
        try count <~> map["count"]
        try next <~> map["next"]
        try previous <~> map["previous"]
        try results <~> map["results"]
    }
}


class TaskItem: BaseModel {
    
    var id: String?
    var expirationDate: String?
    var title: String?
    var taskDescription: String?
    var isComplete: Bool?
    var owner: String?
    
    init(expDate: String, title: String, desc:String, isCompl: Bool) {
        self.expirationDate = expDate
        self.title = title
        self.taskDescription = desc
        self.isComplete = isCompl
    }
    
    required convenience init() {
        self.init(expDate: "",title: "",desc: "",isCompl: false)
    }
    
    override func sequence(_ map: Map) throws {
        try id <~> map["id"]
        try expirationDate <~> map["expiration_date"]
        try title <~> map["title"]
        try taskDescription <~> map["description"]
        try isComplete <~> map["is_complete"]
        try owner <~> map["owner"]
    }
}
