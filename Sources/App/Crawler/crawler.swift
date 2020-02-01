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

    response?.do { string in
        print(string) // The actual String
    }.catch { error in
        print(error) // A Swift Error
    }

//    print(response)
}
