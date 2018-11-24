import Promises
import Dispatch

extension Promise {
    var void: Promise<Void> {
        get {
            return self.then { x in
                ()
            }
        }
    }
}
