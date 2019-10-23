//
//  CategoryController.swift
//  App
//
//  Created by Jagdeep Matharu on 2019-10-18.
//

import Foundation
import Vapor

struct CategoryController: RouteCollection {
    
    let path: PathComponentsRepresentable
    
    init(path: PathComponentsRepresentable...) {
        self.path = path
    }
    
    func boot(router: Router) throws {
        let categoryRoute = router.grouped(path)
        categoryRoute.get("/", use: getAllHandler)
        categoryRoute.get(Category.parameter, use: getHandler)
        categoryRoute.post("/", use: createHandler)
        categoryRoute.get(Category.parameter, "acronyms", use: getAcronymHandler)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Category]> {
        return Category.query(on: req).all()
    }
    
    func getHandler(_ req: Request) throws -> Future<Category> {
        return try req.parameters.next(Category.self)
    }
    
    func createHandler(_ req: Request) throws -> Future<Category> {
        return try req.content.decode(Category.self).save(on: req)
    }
    
    func getAcronymHandler(_ req: Request) throws -> Future<[Acronym]> {
        return try getHandler(req).flatMap(to: [Acronym].self, { category in
            return try category.acronyms.query(on: req).all()
        })
    }
}
