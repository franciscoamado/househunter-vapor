//
//  Imovirtual.swift
//  App
//

import Foundation
import Kanna

class Imovirtual: Provider {

    static var baseURL: String = "https://www.imovirtual.com"
    static var searchURL: String = "https://www.imovirtual.com/arrendar/apartamento/?search%5Bfilter_float_price%3Ato%5D=600&search%5Bfilter_enum_rooms_num%5D%5B0%5D=zero&search%5Bfilter_enum_rooms_num%5D%5B1%5D=1&search%5Bfilter_enum_rooms_num%5D%5B2%5D=2&search%5Bdescription%5D=1&search%5Border%5D=created_at_first%3Adesc&locations%5B0%5D%5Bregion_id%5D=13&locations%5B0%5D%5Bsubregion_id%5D=186&locations%5B0%5D%5Bcity_id%5D=13639692&locations%5B1%5D%5Bregion_id%5D=13&locations%5B1%5D%5Bsubregion_id%5D=186&locations%5B1%5D%5Bcity_id%5D=13639694&locations%5B2%5D%5Bregion_id%5D=13&locations%5B2%5D%5Bsubregion_id%5D=190"
    static var listx: String = "//article[starts-with(@class,\"offer-item\")]"
    static var detailsx: Provider.Details = (
        id: "//article[starts-with(@class,\"offer-item\")]//h3//a/@href",
        title: ".//div[@class=\"offer-item-details\"]//h3//a/span",
        price: ".//li[@class=\"offer-item-price\"]",
        image: ".//span[class=\"img-cover lazy\"]"
    )

    static let hrefx = ".//div[@class=\"offer-item-details\"]//h3//a"
    static let locationx = ".//div[@class=\"offer-item-details\"]//p"

    static func resolve(element article: Kanna.XMLElement) -> House? {
        guard let href = article.at_xpath(hrefx)?["href"]?.trimmingCharacters(in: .whitespacesAndNewlines)
            else { return nil }

        let title = article.at_xpath(detailsx.title)?.content?.trimmingCharacters(in: .whitespacesAndNewlines)
        let location = article.at_xpath(locationx)?.content?
            .split(separator: ":").dropFirst().first?.trimmingCharacters(in: .whitespacesAndNewlines)
        let price = article.at_xpath(detailsx.price)?.content?.split(separator: "€").first?.trimmingCharacters(in: .whitespacesAndNewlines)
        let provider = "\(type(of: self))".split(separator: ".").first.map(String.init)

        return House(
            title: "\(title ?? "") - \(location ?? "")",
            url: href,
            price: price,
            provider: provider
        )
    }
}
