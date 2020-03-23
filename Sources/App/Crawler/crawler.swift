//
//  crawler.swift
//  App
//

import Vapor
import Foundation
import NIO

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

    guard let idealista = Idealista.resolve(in: app),
        let imovirtual = Imovirtual.resolve(in: app)
        else {
            print("ERROR:: couldn't resolve providers")
            return
    }

    _ = idealista.and(imovirtual)
        .map { [$0, $1].joined().map { $0 } }
        .map { Data.shared.saveAndDiff($0) }
        .do { Reporter.update($0, in: app) }
}
