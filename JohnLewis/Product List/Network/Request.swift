import Foundation

protocol Request {
    typealias RequestResult = Result<Data, Error>
    typealias Completion = (RequestResult) -> ()
    func get(from path: String, completion: @escaping Completion)
}
