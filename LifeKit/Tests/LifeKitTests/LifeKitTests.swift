import XCTest
@testable import LifeKit

final class LifeKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(LifeKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
