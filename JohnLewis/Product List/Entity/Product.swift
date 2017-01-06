
struct Product: Equatable {
    let id: String
    let title: String
    let price: String
    let imagePath: String
}

func ==(lhs: Product, rhs: Product) -> Bool {
    return lhs.id == rhs.id
        && lhs.title == rhs.title
        && lhs.price == rhs.price
        && lhs.imagePath == rhs.imagePath
}
