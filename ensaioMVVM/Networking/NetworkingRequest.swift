import Foundation

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) throws -> ModelType
    func execute() async throws -> ModelType
}

extension NetworkRequest {
    func load(_ url: URL) async throws -> ModelType {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decode(data)
    }
}

/**  Generic network request,
     A method for decoding the received data into a model type.
     A method for initiating the asynchronous data transfer.
     An associated model type for decoding the downloaded data.
 */
