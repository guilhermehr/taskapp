//
//  PostRoute.swift
//  ListaTarefas
//
//  Created by ALOC SP08156 on 06/12/2017.
//  Copyright © 2017 ALOC SP08156. All rights reserved.
//

import Foundation
import EasyRest

enum PostRoute: Routable {
    
    case getPosts, login(username: String, password:String)
    
    var rule: Rule {
        switch self {
        case .getPosts:
            return Rule(method: .get, path: "/posts/",
                        isAuthenticable: false, parameters: [:])
        case let .login(username, password):
            return Rule(method: .post, path: "/oauth/token/", isAuthenticable: true, parameters: [.query:
                [
                    "client_id": "vU8bn7KUhBi5A1pewvjl5BUivRMzknxXO81IH9XO",
                    "client_secret": "3OiDg9fEVeEgO52kJcudUPJOk34LBYum1GAy3B6qdi30QC91G8I3OqrcMamEFF24ZVthTNnxC2v7PQp2wEqRGehG7enlk6K3OWsRH6Dt62xrCeTDURbePQr9gVhGmoDg",
                    "grant_type": "password",
                    "username": username,
                    "password": password
                ]
            ])
        }
    }
    
}
