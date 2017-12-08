//
//  TaskRoute.swift
//  taskapp
//
//  Created by Guilherme on 07/12/2017.
//  Copyright © 2017 Guilherme. All rights reserved.
//

import Foundation
import EasyRest

enum TaskRoute: Routable {
    
    case tasks
    case create(task: TaskItem)
    case update(task: TaskItem)
    case delete(task: TaskItem)
    
    
    var rule: Rule {
        switch self {
            
        case let .tasks:
            return Rule(method: .get, path: "/v1/tasks/", isAuthenticable: true, parameters: [:])
        
        case let .create(task):
            return Rule(method: .post, path: "/v1/tasks/", isAuthenticable: true, parameters: [.body:task])
        
        case let .update(task):
            return Rule(method: .put, path: "/v1/tasks/\(task.id!)/", isAuthenticable: true, parameters: [.body:task])
        
        case let .delete(task):
            return Rule(method: .delete, path: "/v1/tasks/\(task.id!)/", isAuthenticable: true, parameters: [:])

        }
    }
    
}

