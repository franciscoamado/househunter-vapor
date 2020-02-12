//
//  Data.swift
//  App
//
//  Created by Francisco Amado on 05/02/2020.
//

import Vapor
import MongoSwift

class Data {

    static let shared: Data = { return Data() }()

    private var results: [House] = []

    func saveAndDiff(_ elements: [House]) -> [House] {
        print("\(#function)")

        guard let pointer = results.first else {

            results += elements
            return Array(elements.prefix(upTo: 10))
        }

        if pointer == elements.first {

            return []

        } else {

            let diff = Array(elements.prefix(upTo: elements.index(of: pointer) ?? 10))
            results += diff

            return diff
        }
    }

    class func save(_ elements: [House], in app: Application) {

        let db = try? app.make(MongoDatabase.self)
        let collection: MongoCollection<House>? = db?.collection("houses", withType: House.self)
//        print("DB \(db)"); print("Collection \(collection)")

//        let cursor = collection?.)
    }

    class func saveAndDiff(_ elements: [House], in app: Application) -> [House] {
        print("\(#function)")

        let db = try? app.make(MongoDatabase.self)

        guard let collection: MongoCollection<House> = db?.collection("houses", withType: House.self)
            else { return [] }

        defer { save(elements, in: collection) }

        guard let cursor = try? collection.find(options: .init(limit: Int64(elements.count))),
            cursor.isAlive == true
            else { return [] }

        let results: [House] = Array(cursor)

        guard let pointer = results.first
            else { return [] }

        if pointer == elements.first {

            return []

        } else {

            let limit = elements.index(of: pointer) ?? elements.count

            return Array(elements.prefix(upTo: limit))
        }
    }

//    class func save<T: MongoItem>(_ elements: [T], in app: Application) {
//
//        let db = try? app.make(MongoDatabase.self)
//        let collection = db?.collection(T.collection, withType: T.self)
//    }

    class func save(_ elements: [House], in collection: MongoCollection<House>) {
        print("\(#function)")
        _ = try? collection.insertMany(elements)
    }
}

extension MongoCursor {
    
}
