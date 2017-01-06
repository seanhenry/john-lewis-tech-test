import Foundation

enum DataParserError: Error {
    case couldNotParseResponse
}

class DataParser<ParsedType> {

    typealias ParsedResult = Result<ParsedType, Error>

    func parse(_ data: Data) -> ParsedResult {
        return .failure(DataParserError.couldNotParseResponse)
    }
}
