import XCTest

import JaneTests

var tests = [XCTestCaseEntry]()
tests += JaneTests.allTests()
XCTMain(tests)