//
//  House.swift
//  App
//
//  Created by Francisco Amado on 01/02/2020.
//

import Vapor

struct House: Equatable {

    var title: String
    var url: String
    var price: String
    var image: String
    var provider: String

    init(
        title: String? = "",
        url: String? = "",
        price: String? = "",
        image: String? = "",
        provider: String? = ""
    ) {

        self.title = title ?? ""
        self.url = url ?? ""
        self.price = price ?? ""
        self.image = image ?? ""
        self.provider = provider ?? ""
    }
}

/// Allows `House` to be encoded to and decoded from HTTP messages.
extension House: Content {}
