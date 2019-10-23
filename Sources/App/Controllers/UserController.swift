//
//  UserController.swift
//  App
//
//  Created by Jagdeep Matharu on 2019-10-18.
//

import Foundation
import Vapor

struct UserController: RouteCollection {
    
    let path: PathComponentsRepresentable
    
    init(path: PathComponentsRepresentable...) {
        self.path = path
    }
    
    func boot(router: Router) throws {
        let userRoute = router.grouped(path)
        userRoute.get("/", use: getAllHandler)
        userRoute.post("/", use: createHandler)
        userRoute.get(User.parameter, use: getHandler)
        userRoute.get(User.parameter, "acronym", use: getAcronymHandler)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    func getHandler(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self)
    }
    
    func createHandler(_ req: Request) throws -> Future<User> {
        return try req.content.decode(User.self).save(on: req)
    }
    
    func getAcronymHandler(_ req: Request) throws -> Future<[Acronym]> {
        return try getHandler(req).flatMap(to: [Acronym].self) { user in
            return try user.acronyms.query(on: req).all()
        }
    }
}
