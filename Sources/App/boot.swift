import Vapor

/// Called after your application has initialized.
public func boot(_ app: Application) throws {

    app.eventLoop.scheduleTask(in: .seconds(3)) {
        Reporter.report("*Starting HouseHunter*", in: app)
    }

    app.eventLoop.scheduleRepeatedTask(initialDelay: .seconds(10), delay: .minutes(30)) { _ in
        crawl(app)
    }
}
