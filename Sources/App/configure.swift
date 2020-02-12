//import FluentSQLite
import MongoSwift
import Vapor

extension MongoDatabase: Service {}

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {

    /// Create HTTP Decoder
//    var httpDecoder = HTTPDecoder()
//    /// Register decoder and content config
//    var contentConfig = ContentConfig.default()
//    contentConfig.use(dataDecoder: httpDecoder, for: .html)
//    services.register(contentConfig)

    // Register providers first
//    try services.register(FluentSQLiteProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a Mongo database
    let mongoDB = try MongoClient().db("HouseHunter")

    // Register the configured database to the database config.
    services.register(mongoDB, as: MongoDatabase.self)

//    databases.add(as: , database: .sqlite)
//    databases.add(database: sqlite, as: .sqlite)
//    services.register(databases)

    // Configure migrations
//    var migrations = MigrationConfig()
//    migrations.add(model: Todo.self, database: .sqlite)
//    services.register(migrations)
}
