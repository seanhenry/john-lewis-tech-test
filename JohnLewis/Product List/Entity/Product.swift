
struct Product: Equatable {
    let title: String
    let price: String
    let imagePath: String
}

func ==(lhs: Product, rhs: Product) -> Bool {
    return lhs.title == rhs.title
        && lhs.price == rhs.price
        && lhs.imagePath == rhs.imagePath
}
