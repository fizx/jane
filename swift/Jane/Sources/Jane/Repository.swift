import Promises
import SwiftProtobuf
import Dispatch

class Repository<V: StorageMappable> {
    let storage: RawStorage
    init(storage: RawStorage) {
        self.storage = storage
    }
    
    func save(_ objs: V...) -> Promise<Void> {
        let promises = objs.map { obj -> Promise<Void> in
            let key = obj.primaryIndex()
            let value = obj.toValue()
            return self.storage.put(key: key!, value: value)
        }
        return all(promises).void
    }
}
