//
//  PostService.swift
//  ListaTarefas
//
//  Created by ALOC SP08156 on 06/12/2017.
//  Copyright © 2017 ALOC SP08156. All rights reserved.
//

import Foundation
import EasyRest

class PostService: Service<PostRoute> {
    
    override var base: String { return AppConfig.kHttpEndpoint }
    
    func getPosts(onSuccess: @escaping (Response<[Post]>?) -> Void,
                  onError: @escaping (RestError?) -> Void,
                  always: @escaping () -> Void) {
        try! call(.getPosts, type: [Post].self, onSuccess: onSuccess,
                  onError: onError, always: always)
    }
    
    func login(username:String, password:String, onSuccess: @escaping (Response<Token>?) -> Void,
                  onError: @escaping (RestError?) -> Void,
                  always: @escaping () -> Void) {
        try! call(.login(username: username, password: password), type: Token.self, onSuccess: onSuccess,
                  onError: onError, always: always)
    }
}

