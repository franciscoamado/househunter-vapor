//
//  Provider.swift
//  App
//
//  Created by Francisco Amado on 18/12/2019.
//

import Async
import Vapor
import NIO
import Kanna

struct House {

    var title: String
    var url: String
    var price: String
    var image: String
    var provider: String
}

/// Allows `House` to be encoded to and decoded from HTTP messages.
extension House: Content {}

protocol Provider {

    typealias Details = (
        id: String,
        title: String,
        price: String,
        image: String
    )

    static var URL: String { get }
    static var listx: String { get }
    static var detailsx: Details { get }

    static func resolve(page: Int, in app: Application) -> Future<[House]>?
}

extension Provider {

    static func resolve(page: Int = 0, in app: Application) -> Future<[House]>? {
        return try? app.client().get(self.URL).map { response in
            // return try response.content.decode(String.self)
            return response.http.body
        }.map { content -> HTMLDocument? in
            guard let data = content.data else { return nil }
            let doc = try? HTML(html: data, encoding: .utf8)
            print(doc?.title)
            return doc
        }.map { document -> [House] in
            typealias Item = (title: String, href: String)
            // Search nodes by XPath
            let articles = document?.xpath(self.listx)
            let houses: [House] = articles?.compactMap { article in
                let title = article.at_xpath(self.detailsx.title)?.content?.trimmingCharacters(in: .whitespacesAndNewlines)
                let href = article.at_xpath(self.detailsx.title)?["href"]?.trimmingCharacters(in: .whitespacesAndNewlines)
                let price = article.at_xpath(self.detailsx.price)?.content?.trimmingCharacters(in: .whitespacesAndNewlines)
//                let image = article.at_xpath(self.detailsx.image)?.content?.trimmingCharacters(in: .whitespacesAndNewlines)
                let image = article.at_xpath(self.detailsx.image)

                
                return House(
                    title: title ?? "",
                    url: href ?? "",
                    price: price ?? "",
                    image: "",
//                    image: image ?? "",
                    provider: "Idealista"
                )
            } ?? []

            return houses
        }
    }
}
