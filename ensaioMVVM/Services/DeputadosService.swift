class DeputadosService {
    static let shared = DeputadosService()
    
    private init() {}
    
    func fetchDeputados(completion: @escaping (Result<[Deputado], Error>) -> Void)  {
        let queue = DispatchQueue(label: "com.deputados.queue", qos: .background)
        queue.async {
            let url = URL(string: "https://dadosabertos.camara.leg.br/api/v2/deputados?ordem=ASC&ordenarPor=nome")!
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let data = data {
                    let parser = DeputadosXMLParserDelegate()
                    if let parsedDeputados = self.parseXML(data, parser: parser) {
                        completion(.success(parsedDeputados))
                    } else {
                        let parsingError = NSError(domain: "ParsingError", code: 0, userInfo: nil)
                        completion(.failure(parsingError))
                    }
                }
            }.resume()
        }
    }
}