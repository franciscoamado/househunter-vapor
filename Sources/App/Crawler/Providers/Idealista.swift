//
//  Idealista.swift
//  App
//

import Foundation
import Kanna

class Idealista: Provider {

    static var baseURL: String = "https://www.idealista.pt"
    static var searchURL: String = "https://www.idealista.pt/en/areas/arrendar-casas/com-preco-max_650,t1,t2/?shape=%28%28ibozFzmft%40e_AwvBopDayL%7ESupBlmFujBvdBo%7EGpfHrjD%3Ff%7EQa%7EKxbH%29%29&ordem=atualizado-desc"
    static var listx: String = "//article[starts-with(@class,\"item item\")]"
    static var detailsx: Provider.Details = (
        id: "//article[starts-with(@class,\"item item\")]//div[@class=\"item-info-container\"]//a[@class=\"item-link \"]",
        title: ".//div[@class=\"item-info-container\"]//a[@class=\"item-link \"]",
        price: ".//div[@class=\"row price-row clearfix\"]",
        image: ".//div[@class=\"item-gallery\"]//img[1]"
    )

    static func resolve(element article: Kanna.XMLElement) -> House? {
        guard let href = article.at_xpath(detailsx.title)?["href"]?.trimmingCharacters(in: .whitespacesAndNewlines)
            else { return nil }

        let url = self.baseURL + href
        let title = article.at_xpath(detailsx.title)?.content?.trimmingCharacters(in: .whitespacesAndNewlines)
        let price = article.at_xpath(detailsx.price)?.content?.trimmingCharacters(in: .whitespacesAndNewlines)
        let provider = "\(type(of: self))".split(separator: ".").first.map(String.init)

        return House(
            title: title,
            url: url,
            price: price,
            provider: provider
        )
    }
}
