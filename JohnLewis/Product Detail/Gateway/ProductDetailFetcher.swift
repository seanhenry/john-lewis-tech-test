
typealias ProductDetailResult = Result<ProductDetail, Error>

protocol ProductDetailFetcher {
    func fetch(id: String, _ completion: @escaping (ProductDetailResult) -> ())
}
