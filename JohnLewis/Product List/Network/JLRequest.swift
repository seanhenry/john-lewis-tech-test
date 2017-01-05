import Foundation

class JLRequest: Request {

    enum Error: Swift.Error {
        case unknownError
    }

    let baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    func get(from path: String, completion: @escaping Request.Completion) {
        let mainThreadCompletion = wrapCompletionInMainThread(completion: completion)
        let task = URLSession.shared.dataTask(with: URL(string: baseURL.absoluteString + path)!) { [weak self] (data, _, error) in
            self?.handleResponse(data: data, error: error, completion: mainThreadCompletion)
        }
        task.resume()
    }

    private func handleResponse(data: Data?, error: Swift.Error?, completion: Request.Completion) {
        if let error = error {
            completion(.failure(error))
        } else if let data = data {
            completion(.success(data))
        } else {
            completion(.failure(Error.unknownError))
        }
    }
    
    private func wrapCompletionInMainThread(completion: @escaping Request.Completion) -> Request.Completion {
        return { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
