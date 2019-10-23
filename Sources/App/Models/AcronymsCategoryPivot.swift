//
//  AcronymsCategoryPivot.swift
//  App
//
//  Created by Jagdeep Matharu on 2019-10-21.
//

import Foundation
import Vapor
import FluentMySQL

final class AcronymsCategoryPivot: MySQLUUIDPivot {
    var id: UUID?
    var acronymID: Acronym.ID
    var categoryID: Category.ID
    
    typealias Left = Acronym
    typealias Right = Category
    
    static var leftIDKey: LeftIDKey = \AcronymsCategoryPivot.acronymID
    static var rightIDKey: RightIDKey = \AcronymsCategoryPivot.categoryID
    
    init(_ acronymID: Acronym.ID, _ categoryID: Category.ID) {
        self.acronymID = acronymID
        self.categoryID = categoryID
    }
}

extension AcronymsCategoryPivot: Migration {}
