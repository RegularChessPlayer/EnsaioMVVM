import Foundation

internal class AssemblyManService {
    
    internal func getAssembliesmanGeneralInfo(completion: @escaping (Result<ResponseAssemblyman, Error>) -> ()) {
        
        let endpoint = "https://dadosabertos.camara.leg.br/api/v2/deputados?ordem=ASC&ordenarPor=nome"
        let url = URL(string: endpoint)!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, _,error in
            if let data = data {
                /// do exception handler so that our app does not crash
                do {
                    let result = try JSONDecoder().decode(ResponseAssemblyman.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
}
