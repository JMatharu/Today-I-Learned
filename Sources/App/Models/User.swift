//
//  User.swift
//  App
//
//  Created by Jagdeep Matharu on 2019-10-18.
//

import Foundation
import FluentMySQL
import Vapor

final class User: Codable {
    var id: UUID?
    var name: String
    var userName: String
    
    init(name: String, userName: String) {
        self.name = name
        self.userName = userName
    }
}

extension User: MySQLUUIDModel, Content, Migration, Parameter {}

extension User {
    var acronyms: Children<User, Acronym> {
        return children(\.createrID)
    }
}
