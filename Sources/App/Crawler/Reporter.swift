//
//  Reporter.swift
//  App
//

import Vapor

class Reporter {

    static let baseURL = "https://api.telegram.org/bot"

    static var sendMessageURL: URL? {

        guard let token = Environment.get("TOKEN"),
            let sendMessage =  URL(string: baseURL + token + "/sendMessage")
            else { return nil}

        return sendMessage
    }

    class func update(_ elements: [House], in app: Application) {
        print("\(#function)")

        guard elements.count > 0 else { return }

        report("*Latest Houses*", in: app)

        elements.forEach {

            let text = content(from: $0)
            report(text, in: app)
        }
    }

    class func report(_ text: String, in app: Application) {

           guard let sendMessageURL = self.sendMessageURL,
                let chatId = Environment.get("CHAT_ID")
               else { return }

           _ = try? app.client().get(sendMessageURL) { get in

               try get.query.encode([
                   "chat_id": chatId,
                   "text": text,
                   "parse_mode":"Markdown"])

           }.do { response in

               print(response.http.body)
           }
       }

    class func content(from elements: [House]) -> String {
        return (["*Latest Houses*"] + elements.map(content)).joined(separator: "\n\n")
    }

    class func content(from element: House) -> String {
        return """
        \(element.title)
        _\(element.price)_
        \(element.url)
        """
    }
}
