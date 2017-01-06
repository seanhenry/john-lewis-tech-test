import Foundation
import SwiftyJSON

class NetworkProductDetailFetcher: Fetcher<ProductDetail>, ProductDetailFetcher {

    init(request: Request) {
        super.init(request: request, parser: Parser())
    }

    func fetch(id: String, _ completion: @escaping (ProductDetailResult) -> ()) {
        fetch(path: "/products/\(id)", completion: completion)
    }

    class Parser: DataParser<ProductDetail> {

        override func parse(_ data: Data) -> ParsedResult {
            let json = JSON(data: data)
            guard let title = json["title"].string,
                  let price = json["price"]["now"].string,
                  let imagePath = json["media"]["images"]["urls"].first?.1.string,
                  let description = json["details"]["productInformation"].string,
                  let guarantee = json["additionalServices"]["includedServices"].first?.1.string else {
                return .failure(DataParserError.couldNotParseResponse)
            }
            return .success(ProductDetail(title: title, price: "£" + price, imagePath: imagePath, description: description, guarantee: guarantee))
        }
    }
}
