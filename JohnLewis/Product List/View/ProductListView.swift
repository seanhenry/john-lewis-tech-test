
protocol ProductListView: class {
    func showErrorMessage(_ message: String)
    func showProducts(_ products: [Product])
}
