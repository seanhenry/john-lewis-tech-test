import Foundation

typealias ProductDetailResult = Result<Void, Error>

class NetworkProductDetailFetcher: Fetcher<Void> {

    init(request: Request) {
        super.init(request: request, parser: Parser())
    }

    func fetch(id: String, _ completion: @escaping (ProductDetailResult) -> ()) {
        fetch(path: "/products/\(id)", completion: completion)
    }

    class Parser: DataParser<Void> {

        override func parse(_ data: Data) -> ParsedResult {
            return .failure(DataParserError.couldNotParseResponse)
        }
    }
}
