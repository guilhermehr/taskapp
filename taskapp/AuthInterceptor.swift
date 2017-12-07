//
//  Interceptor.swift
//  taskapp
//
//  Created by Guilherme on 07/12/2017.
//  Copyright © 2017 Guilherme. All rights reserved.
//

import Foundation
import Genome
import Alamofire
import EasyRest


open class AuthInterceptor: Interceptor {
    
    required public init() {}
    
    open func requestInterceptor<T: NodeInitializable>(_ api: API<T>) {
        
        if let token = UserDefaults.standard.string(forKey: AppConfig.TOKEN_LOGADO) {
            api.headers["Authorization"] = "Bearer \(token)"
        }
    }
    
    open func responseInterceptor<T: NodeInitializable>(_ api: API<T>, response: DataResponse<Any>) {
    
    }
    
}
