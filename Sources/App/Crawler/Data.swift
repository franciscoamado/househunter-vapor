//
//  Data.swift
//  App
//

import Vapor

class Data {

    static let shared: Data = { return Data() }()

    private var results: [House] = []

    func saveAndDiff(_ elements: [House]) -> [House] {
        print("\(#function)")

        guard results.isEmpty == false, elements.isEmpty == false else {

            results += elements
            return []
        }

        let diff = elements.filter { results.contains($0) == false }

        print("diff \(diff.count)")

        guard diff.isEmpty == false else { return [] }

        results += diff
        return diff
    }
}
