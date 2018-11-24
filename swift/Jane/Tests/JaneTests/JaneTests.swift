import XCTest
import Swinject
import SwinjectAutoregistration
import Promises
@testable import Jane

final class JaneTests: XCTestCase {
    var c: Container = Container()
    
    override func setUp() {
        DispatchQueue.promises = .global()
        c.autoregister(RawStorage.self, initializer: MemoryStorage.init)
        Example_Binder.bind(c)
    }
    
    func testCanBind() {
    }
    
    func testFindOne() throws {
        let repo = c.resolve(Example_User.repository())!
        let user = Example_User.with { $0.id = "kyle" }
        try await(repo.save(user))
        let saved = try await(repo.findById(user.id))
        XCTAssertNotNil(saved)
        XCTAssertEqual(saved?.id, user.id)
    }
    
    func testFindAll() throws {
        let repo = c.resolve(Example_User.repository())!
        let a = Example_User.with { $0.id = "kyle" }
        let b = Example_User.with { $0.id = "kyle" }
        try await(repo.save(a, b))
        let saved = try await(repo.findByIds([a.id, b.id, "unknown"]))
        XCTAssertEqual(saved, [a, b, nil])
    }
    
    static var allTests = [
        ("testExample", testCanBind, testFindOne, testFindAll),
    ]
}
