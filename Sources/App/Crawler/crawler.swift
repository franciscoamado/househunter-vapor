//
//  crawler.swift
//  App
//
//  Created by Francisco Amado on 30/11/2019.
//

import Vapor
import Foundation
import NIO
import MongoSwift

//public func crawl(_ task: RepeatedTask) {
//    print("crawl \(task)")
//}

public func crawl(_ app: Application) {
    print("crawl \(app)")

    let response = Idealista.resolve(in: app)

    let db = try? app.make(MongoDatabase.self)
    let collection = db?.collection("houses", withType: House.self)
    print(db)
    print(collection)
    response?.do { string in
        print(string) // The actual String
    }.catch { error in
        print(error) // A Swift Error
    }

//    print(response)
}
