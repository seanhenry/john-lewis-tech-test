import Foundation

typealias ImageFetcherResult = Result<Data, Error>

protocol ImageFetcher {
    func fetch(from url: URL, completion: @escaping (ImageFetcherResult) -> ())
}
