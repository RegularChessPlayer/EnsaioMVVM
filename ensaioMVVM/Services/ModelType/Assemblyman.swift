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
