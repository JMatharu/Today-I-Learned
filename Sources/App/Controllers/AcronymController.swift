//
//  AcronymController.swift
//  App
//
//  Created by Jagdeep Matharu on 2019-10-18.
//

import Foundation
import Vapor
import Fluent

struct AcronymController: RouteCollection {
    let path: PathComponentsRepresentable
    
    init(path: PathComponentsRepresentable...) {
        self.path = path
    }
    
    func boot(router: Router) throws {
        let acronymsRoute = router.grouped(path)
        acronymsRoute.get("/", use: getAllHandler)
        acronymsRoute.post("/", use: createHandler)
        acronymsRoute.get(Acronym.parameter, use: getHandler)
        acronymsRoute.delete(Acronym.parameter, use: deleteHandler)
        acronymsRoute.put(Acronym.parameter, use: updateHandler)
        acronymsRoute.get(Acronym.parameter, "creator", use: getCreatorHandler)
        acronymsRoute.get(Acronym.parameter, "categories", use: getCategoriesHandler)
        acronymsRoute.post(Acronym.parameter, "categories", Category.parameter, use: addCategoriesHandler)
        acronymsRoute.get("search", use: searchHandler)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Acronym]> {
        return Acronym.query(on: req).all()
    }
    
    func createHandler(_ req: Request) throws -> Future<Acronym> {
        return try req.content.decode(Acronym.self).save(on: req)
    }
    
    func getHandler(_ req: Request) throws -> Future<Acronym> {
        return try req.parameters.next(Acronym.self)
    }
    
    func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try getHandler(req).flatMap(to: HTTPStatus.self) { acronym in
            return acronym.delete(on: req).transform(to: .noContent)
        }
    }
    
    func updateHandler(_ req: Request) throws -> Future<Acronym> {
        return try flatMap(to: Acronym.self, getHandler(req), req.content.decode(Acronym.self), { acronym, updatedAcronym in
            acronym.long = updatedAcronym.long
            acronym.short = updatedAcronym.short
            return acronym.save(on: req)
        })
    }
    
    func getCreatorHandler(_ req: Request) throws -> Future<User> {
        return try getHandler(req).flatMap(to: User.self) { acronym in
            return acronym.creator.get(on: req)
        }
    }
    
    func getCategoriesHandler(_ req: Request) throws -> Future<[Category]> {
        return try getHandler(req).flatMap(to: [Category].self, { acronym in
            return try acronym.categories.query(on: req).all()
        })
    }
    
    func addCategoriesHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try flatMap(to: HTTPStatus.self,
                           req.parameters.next(Acronym.self),
                           req.parameters.next(Category.self), { (acronym, category) in
                            let pivot = try AcronymsCategoryPivot(acronym.requireID(), category.requireID())
                            return pivot.save(on: req).transform(to: .ok)
        })
    }
    
    func searchHandler(_ req: Request) throws -> Future<[Acronym]> {
        guard let searchTerm = req.query[String.self, at: "term"] else {
            throw Abort(.badRequest, reason: "Missing search term in request")
        }
        return Acronym.query(on: req).group(.or) { or in
            or.filter(\.short == searchTerm)
            or.filter(\.long == searchTerm)
        }.all()
    }
}

extension Acronym: Parameter {}
