//
//  Idealista.swift
//  App
//
//  Created by Francisco Amado on 18/12/2019.
//

class Idealista: Provider {

    static var URL: String = "https://www.idealista.pt/en/areas/arrendar-casas/com-preco-max_699,t1,t2/?shape=%28%28ibozFzmft%40e_AwvBopDayL%7ESupBlmFujBvdBo%7EGpfHrjD%3Ff%7EQa%7EKxbH%29%29&ordem=atualizado-desc"
    static var listx: String = "//article[starts-with(@class,\"item item\")]"
    static var detailsx: Provider.Details = (
        id: "//article[starts-with(@class,\"item item\")]//div[@class=\"item-info-container\"]//a[@class=\"item-link \"]",
        title: ".//div[@class=\"item-info-container\"]//a[@class=\"item-link \"]",
        price: ".//div[@class=\"row price-row clearfix\"]",
        image: ".//div[@class=\"item-gallery\"]//img[1]"
//        image: ".//div[@class=\"item-gallery\"]//div[@class=\"placeholder\"][*][1]//img"
    )
}
