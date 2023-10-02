import Foundation

internal struct ResponseAssemblyman: Codable {
    
    let dados: [Assemblyman]

}

internal struct Assemblyman: Codable {
    
    let email: String
    let id: Int
    let idLegislatura: Int
    let siglaPartido: String
    let siglaUf: String
    let uri: String
    let uriPartido: String
    let urlFoto: String
    
}

extension URL {
    static var allAssemblyman: URL {
        return  URL(string: "https://dadosabertos.camara.leg.br/api/v2/deputados?ordem=ASC&ordenarPor=nome")!
    }
}

extension Assemblyman {
    
    static var all: Resource<[Assemblyman]> {
        return Resource(url: URL.allAssemblyman)
    }
    
}
