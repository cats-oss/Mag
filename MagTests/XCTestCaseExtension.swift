import XCTest

extension XCTestCase {
    func expect<T>(_ expression: @autoclosure @escaping () throws -> T?, file: StaticString = #file, line: UInt = #line) -> Expectation<T> {
        Expectation(value: expression, file: file, line: line)
    }
}
