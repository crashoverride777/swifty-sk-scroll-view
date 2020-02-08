import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(swifty_sk_scroll_viewTests.allTests),
    ]
}
#endif
