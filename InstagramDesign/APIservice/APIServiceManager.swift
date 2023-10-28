import Foundation

enum APIError: Error {
    case serviceError(String)
    case unKnownError
    case decodingError
}

struct Constants {
    static let baseUrl = "https://run.mocky.io/v3/3d96dcfe-789b-4808-9125-fe514a1c4c55"
}

protocol APIServiceProtocol {
    func excute<Value: Decodable>(_ request: Value.Type, completion: @escaping (Result<Value, APIError>) -> Void)
}

final class APIServiceManager: APIServiceProtocol {
    
    static let shared = APIServiceManager()
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func excute<Value: Decodable>(_ request: Value.Type, completion: @escaping (Result<Value, APIError>) -> Void) {
        let request = URLRequest(url: URL(string: Constants.baseUrl)!)
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.serviceError(error!.localizedDescription)))
                return
            }
            guard let data = data else {
                completion(.failure(.unKnownError))
                return
            }
            do {
                let model = try JSONDecoder().decode(Value.self, from: data)
                completion(.success(model))
            } catch _ {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

