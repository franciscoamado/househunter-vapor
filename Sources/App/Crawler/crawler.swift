//
//  crawler.swift
//  App
//
//  Created by Francisco Amado on 30/11/2019.
//

import Vapor
import Foundation
import NIO
// import MongoSwift

//public func crawl(_ task: RepeatedTask) {
//    print("crawl \(task)")
//}

public func crawl(_ app: Application) {
    print("crawl \(app)")

// For each Provider:
// - Resolve (Crawl HTML >> Parse into Array of Houses)
// - Store in DB (or in Memory for now)
// - Get an array with the updated houses (based on the diff)
// - Report to Telegram

// Test Telegram
//    guard let token = Environment.get("TOKEN"),
//        let url = URL(string:  "https://api.telegram.org/bot" + token + "/getUpdates")
//        else { return }
//
//    _ = try? app.client().get(url).do { response in
//
//        print(response.http.body)
//    }

// Idealista
//    _ = Idealista.resolve(in: app)?.map { houses in
//
//        return Data.shared.saveAndDiff(houses)
//
//    }.do { houses in
//
//        Reporter.update(houses, in: app)
//    }

    guard let idealista = Idealista.resolve(in: app),
        let imovirtual = Imovirtual.resolve(in: app)
        else {
            print("ERROR:: couldn't resolve providers")
            return
    }

    idealista.and(imovirtual)
        .map { [$0, $1].joined().map { $0 } }
        .map { Data.shared.saveAndDiff($0) }
        .do { Reporter.update($0, in: app) }

//    response?.do { string in
//        print(string) // The actual String
//    }.catch { error in
//        print(error) // A Swift Error
//    }

//    print(response)
}
