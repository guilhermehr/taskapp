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
    
    var rule: Rule {
        switch self {
            
        case let .tasks:
            
            return Rule(method: .get, path: "/v1/tasks/", isAuthenticable: true, parameters: [:])
        }
    }
    
}

