//
//  Acronym.swift
//  App
//
//  Created by Jagdeep Matharu on 2019-10-18.
//

import Foundation
import FluentMySQL
import Vapor

final class Acronym: Codable {
    var id: Int?
    var short: String
    var long: String
    var createrID: User.ID
    
    init(short: String, long: String, createrID: User.ID) {
        self.short = short
        self.long = long
        self.createrID = createrID
    }
}

//extension Acronym: Model {
//    typealias Database = SQLiteDatabase
//    typealias ID = Int
//
//    static let idKey: IDKey = \Acronym.id
//}

extension Acronym: MySQLModel {}
extension Acronym: Content {}
extension Acronym: Migration {}

extension Acronym {
    var creator: Parent<Acronym, User> {
        return parent(\.createrID)
    }
    
    var categories: Siblings<Acronym, Category, AcronymsCategoryPivot> {
        return siblings()
    }
}
