import Foundation

protocol RequestFactory {
    func create(fromURL url: URL) -> Request
}
