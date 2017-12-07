//
//  TaskService.swift
//  taskapp
//
//  Created by Guilherme on 07/12/2017.
//  Copyright © 2017 Guilherme. All rights reserved.
//

import Foundation
import EasyRest

class TaskService: Service<TaskRoute> {
    
    override var base: String { return AppConfig.kHttpEndpoint }
    
    override var interceptors: [Interceptor]? {return [AuthInterceptor()]}
    
    func tasks(onSuccess: @escaping (Response<Tasks>?) -> Void,
               onError: @escaping (RestError?) -> Void,
               always: @escaping () -> Void) {
        try! call(.tasks, type: Tasks.self, onSuccess: onSuccess,
                  onError: onError, always: always)
    }
    
    func create(task: TaskItem, onSuccess: @escaping (Response<TaskItem>?) -> Void,
               onError: @escaping (RestError?) -> Void,
               always: @escaping () -> Void) {
        try! call(.create(task: task), type: TaskItem.self, onSuccess: onSuccess, onError: onError, always: always)
    }

    
}
