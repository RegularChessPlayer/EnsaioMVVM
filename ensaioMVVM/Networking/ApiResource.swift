import Foundation
/*
    The generic Request approach described earlier is a step in the right direction.
    All remote resources should be represented by a corresponding model type in our app.
*/

protocol APIResource {
    associatedtype ModelType: Codable
    var methodPath: String { get }
}

extension APIResource {
    var url: URL {
        let url = URL(string: "https://dadosabertos.camara.leg.br/api/v2/")!
            .appendingPathComponent(methodPath)
            .appending(queryItems: [
                URLQueryItem(name: "ordem", value: "ASC"),
                URLQueryItem(name: "ordenarPor", value: "nome"),
            ])
        return url
    }
}
