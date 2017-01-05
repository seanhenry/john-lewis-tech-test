
enum Result<ResultType, ErrorType> {
    case success(ResultType)
    case failure(ErrorType)
}

extension Result {
    
    var result: ResultType? {
        guard case .success(let result) = self else {
            return nil
        }
        return result
    }
    
    var error: ErrorType? {
        guard case .failure(let error) = self else {
            return nil
        }
        return error
    }

    var isSuccess: Bool {
        guard case .success = self else {
            return false
        }
        return true
    }
}

extension Result where ResultType: Equatable {
    
    func isSuccess(with result: ResultType?) -> Bool {
        guard case .success(let r) = self else {
            return false
        }
        return r == result
    }
}

extension Result where ErrorType: Equatable {
    
    func isFailure(with error: ErrorType?) -> Bool {
        guard case .failure(let e) = self else {
            return false
        }
        return e == error
    }
}

