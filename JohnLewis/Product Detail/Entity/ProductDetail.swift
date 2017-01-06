import Foundation

struct ProductDetail: Equatable {
    let title: String
    let price: String
    let imagePath: String
    let description: String
    let guarantee: String
}

func ==(lhs: ProductDetail, rhs: ProductDetail) -> Bool {
    return lhs.title == rhs.title
        && lhs.price == rhs.price
        && lhs.imagePath == rhs.imagePath
        && lhs.description == rhs.description
        && lhs.guarantee == rhs.guarantee
}
