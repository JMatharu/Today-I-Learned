//
//  Category.swift
//  App
//
//  Created by Jagdeep Matharu on 2019-10-18.
//

import Foundation
import FluentMySQL
import Vapor

final class Category: Codable {
    var id: Int?
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Category: MySQLModel, Content, Migration, Parameter {}

extension Category {
    var acronyms: Siblings<Category, Acronym, AcronymsCategoryPivot> {
        return siblings()
    }
}
