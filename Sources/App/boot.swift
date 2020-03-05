import Vapor

/// Called after your application has initialized.
public func boot(_ app: Application) throws {
    // Your code here
//    app.eventLoop.scheduleRepeatedTask(initialDelay: .seconds(1), delay: .seconds(3), crawl)
    app.eventLoop.scheduleRepeatedTask(initialDelay: .seconds(10), delay: .minutes(20)) { _ in
        crawl(app)
    }
}
