
typealias ProductListFetcherResult = Result<[Product], Error>

protocol ProductListFetcher {
    func fetch(completion: @escaping (ProductListFetcherResult) -> ())
}
