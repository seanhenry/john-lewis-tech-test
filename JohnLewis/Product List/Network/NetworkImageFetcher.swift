import Foundation

class NetworkImageFetcher: ImageFetcher {

    enum Error: Swift.Error {
        case requestAlreadyInProgress
    }

    private let requestFactory: RequestFactory
    private var requests = [URL: Request]()

    init(requestFactory: RequestFactory = DefaultRequestFactory()) {
        self.requestFactory = requestFactory
    }

    func fetch(from url: URL, completion: @escaping (ImageFetcherResult) -> ()) {
        guard requests[url] == nil else {
            completion(.failure(Error.requestAlreadyInProgress))
            return
        }
        let request = requestFactory.create(fromURL: url)
        requests[url] = request
        request.get(from: "") { [weak self] result in
            _ = self?.requests.removeValue(forKey: url)
            completion(result)
        }
    }
}
