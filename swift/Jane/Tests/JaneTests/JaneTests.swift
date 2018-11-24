import XCTest
import Swinject
import SwinjectAutoregistration
@testable import Jane

final class JaneTests: XCTestCase {
    func testCanBind() {
        let c = Container()
        c.autoregister(RawStorage.self, initializer: MemoryStorage.init)
        Example_Binder.bind(c)
    }
    
    func testHappyPathFind() {
        let c = Container()
        c.autoregister(RawStorage.self, initializer: MemoryStorage.init)
        Example_Binder.bind(c)
        let repo = c.resolve(Example_User.repository())
        let user = Example_User.with { $0.login = "kyle" }
        await(repo.save(user))
    }

    static var allTests = [
        ("testExample", testCanBind, testHappyPathFind),
    ]
}
