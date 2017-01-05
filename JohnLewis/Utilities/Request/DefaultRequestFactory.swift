import Foundation

class DefaultRequestFactory: RequestFactory {

    func create(fromURL url: URL) -> Request {
        return JLRequest(baseURL: url)
    }
}
