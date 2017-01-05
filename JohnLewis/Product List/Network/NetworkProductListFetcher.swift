import Foundation
import SwiftyJSON

class NetworkProductListFetcher {

    enum Error: Swift.Error {
        case couldNotParseResponse
    }

    typealias FetchResult = Result<[Product], Swift.Error>
    private let request: Request

    init(request: Request) {
        self.request = request
    }

    func fetch(completion: @escaping (FetchResult) -> ()) {
        request.get(from: "/products/search?pageSize=20") { [weak self] result in
            self?.handleResponse(result: result, completion: completion)
        }
    }

    private func handleResponse(result: Request.RequestResult, completion: (FetchResult) -> ()) {
        switch result {
        case .failure(let error):
            completion(.failure(error))
        case .success(let response):
            completion(parse(response))
        }
    }

    private func parse(_ response: Data) -> FetchResult {
        guard let products = JSON(data: response)["products"].array else {
            return .failure(Error.couldNotParseResponse)
        }
        return .success(products.flatMap(toProduct))
    }

    private func toProduct(json: JSON) -> Product? {
        guard let title = json["title"].string,
              let price = json["price"]["now"].string,
              let imagePath = json["image"].string else {
            return nil
        }
        return Product(title: title, price: "£" + price, imagePath: imagePath)
    }
}
