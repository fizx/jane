import Promises
import SwiftProtobuf

class Repository<V: StorageMappable> {
    let storage: RawStorage
    init(storage: RawStorage) {
        self.storage = storage
    }
    
    func save(_ obj: V) -> Promise<Void> {
        let key = obj.primaryIndex()
        let value = obj.toValue()
        return self.storage.put(key: key!, value: value)
    }
}
