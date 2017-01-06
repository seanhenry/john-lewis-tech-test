import Foundation
import SwiftyJSON

class NetworkProductListFetcher: Fetcher<[Product]>, ProductListFetcher {

    init(request: Request) {
        super.init(request: request, parser: Parser())
    }

    func fetch(completion: @escaping (ProductListFetcherResult) -> ()) {
        fetch(path: "/products/search?q=dishwasher&pageSize=20", completion: completion)
    }

    class Parser: DataParser<[Product]> {

        override func parse(_ data: Data) -> ParsedResult {
            guard let products = JSON(data: data)["products"].array else {
                return .failure(DataParserError.couldNotParseResponse)
            }
            return .success(products.flatMap(toProduct))
        }

        private func toProduct(json: JSON) -> Product? {
            guard let id = json["productId"].string,
                  let title = json["title"].string,
                  let price = json["price"]["now"].string,
                  let imagePath = json["image"].string else {
                return nil
            }
            let fixedImagePath = URLSchemeFixer.fixMissingScheme(in: imagePath)
            return Product(id: id, title: title, price: "£" + price, imagePath: fixedImagePath)
        }
    }
}
