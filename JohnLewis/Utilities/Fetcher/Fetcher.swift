import Foundation

class Fetcher<ResultType> {

    typealias FetcherResult = Result<ResultType, Error>
    private let request: Request
    private let parser: DataParser<ResultType>

    init(request: Request, parser: DataParser<ResultType>) {
        self.request = request
        self.parser = parser
    }

    func fetch(path: String, completion: @escaping (FetcherResult) -> ()) {
        request.get(from: path) { [weak self] result in
            self?.handleResponse(result: result, completion: completion)
        }
    }

    private func handleResponse(result: Request.RequestResult, completion: (FetcherResult) -> ()) {
        switch result {
        case .failure(let error):
            completion(.failure(error))
        case .success(let response):
            completion(parser.parse(response))
        }
    }
}
