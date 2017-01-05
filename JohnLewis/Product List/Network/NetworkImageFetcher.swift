import Foundation

class NetworkImageFetcher {

    typealias ImageFetcherResult = Result<Data, Error>

    private let requestFactory: RequestFactory
    private var requests = [String: Request]()

    init(requestFactory: RequestFactory = DefaultRequestFactory()) {
        self.requestFactory = requestFactory
    }

    func fetch(from url: URL, completion: @escaping (ImageFetcherResult) -> ()) {
        let request = requestFactory.create(fromURL: url)
        request.get(from: "", completion: completion)
    }
}
