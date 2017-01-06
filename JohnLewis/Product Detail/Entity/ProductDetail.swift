import Foundation

struct ProductDetail: Equatable {
    let title: String
    let imagePath: String
    let description: String
}

func ==(lhs: ProductDetail, rhs: ProductDetail) -> Bool {
    return lhs.title == rhs.title
        && lhs.imagePath == rhs.imagePath
        && lhs.description == rhs.description
}
