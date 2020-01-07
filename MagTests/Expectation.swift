import XCTest

struct Expectation<T: Equatable> {
    typealias Expect = T

    var result: Result<Expect?, Error>
    var file: StaticString
    var line: UInt

    init(value: () throws -> Expect?, file: StaticString = #file, line: UInt = #line) {
        do {
            result = .success(try value())
        }
        catch {
            result = .failure(error)
        }
        self.file = file
        self.line = line
    }
}

extension Expectation {
    static func == (lhs: Expectation, rhs: Expectation.Expect?) {
        switch (lhs.result, rhs) {
        case (.success(.none), _):
            XCTAssertEqual(nil, rhs, file: lhs.file, line: lhs.line)

        case (.success(let value?), .none):
            XCTAssertEqual(value, nil, file: lhs.file, line: lhs.line)

        case (.success(let value?), let rhs?):
            XCTAssertEqual(value, rhs, file: lhs.file, line: lhs.line)

        case (.failure(let error), _):
            XCTFail(error.localizedDescription, file: lhs.file, line: lhs.line)
        }
    }
}
