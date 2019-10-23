import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    let acronumController = AcronymController(path: "api", "acronyms")
    try router.register(collection: acronumController)
    
    let userController = UserController(path: "api", "users")
    try router.register(collection: userController)
    
    let categoryController = CategoryController(path: "api", "categories")
    try router.register(collection: categoryController)
}
