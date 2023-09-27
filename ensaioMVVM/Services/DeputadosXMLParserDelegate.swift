import Foundation

class DeputadosXMLParserDelegate: NSObject, XMLParserDelegate {
    enum Element: String {
        case deputado
        case id
        case nome
        case urlFoto
        case email
    }
    
    var deputados: [Deputado] = []
    var currentDeputado: Deputado?
    var parsingElement: Element?
    
    let elementMapping: [Element: (String) -> Void] = [
        .id: { self.currentDeputado?.id = $0 },
        .nome: { self.currentDeputado?.nome = $0 },
        .urlFoto: { self.currentDeputado?.fotoURL = URL(string: $0) },
        .email: { self.currentDeputado?.email = $0 }
    ]
    
    func parser(_ parser: XMLParser, 
                didStartElement elementName: String, 
                namespaceURI: String?, 
                qualifiedName qName: String?, 
                attributes attributeDict: [String : String]) {
        if let element = Element(rawValue: elementName) {
            parsingElement = element
            if element == .deputado {
                currentDeputado = Deputado(id: "", 
                                           nome: "", 
                                           fotoURL: nil, 
                                           email: "")
            }
        }
    }
    
    func parser(_ parser: XMLParser, 
                foundCharacters string: String) {
        if let element = parsingElement {
            if let updateField = elementMapping[element] {
                updateField(string)
            }
        }
    }
    
    func parser(_ parser: XMLParser, 
                didEndElement elementName: String, 
                namespaceURI: String?, 
                qualifiedName qName: String?) {
        if elementName == Element.deputado.rawValue {
            if let deputado = currentDeputado {
                deputados.append(deputado)
            }
            currentDeputado = nil
        }
        parsingElement = nil
    }
}