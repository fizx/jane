import Algorithm
import Foundation
import Promises

struct Index: Hashable {
    var name: BytesWrapper
    var unique: Bool = false
}

protocol StorageMapper {
    associatedtype V
    func toValue(v: V) -> BytesWrapper
    func primaryIndex(v: V) -> BytesWrapper?
    func secondaryIndexes(v: V) -> [Index: BytesWrapper]
}

protocol StorageMappable {
    func toValue() -> BytesWrapper
    func primaryIndex() -> BytesWrapper?
    func secondaryIndexes() -> [Index: BytesWrapper]
}

protocol RawStorage {
    func get(key: BytesWrapper) -> Promise<BytesWrapper?>
    func range(from: BytesWrapper, to: BytesWrapper, inclusive: Bool) -> Promise<[BytesWrapper]>
    func put(key: BytesWrapper, value: BytesWrapper) -> Promise<Void>
    func remove(key: BytesWrapper) -> Promise<Void>
    func transactionally(key: BytesWrapper, transaction: @escaping () -> Promise<Void>) -> Promise<Void>
}

struct BytesWrapper: Comparable, Equatable, Hashable, Codable {
    let array: [UInt8]
    init(data: Data) {
        self.array = [UInt8](data)
    }
    init(array: [UInt8]) {
        self.array = array
    }
    init(string: String) {
        self.array = Array(string.utf8)
    }
    
    func toData() -> Data {
        return Data(self.array)
    }
    
    static func < (lhs: BytesWrapper, rhs: BytesWrapper) -> Bool {
        for (l, r) in zip(lhs.array, rhs.array) {
            if (l < r) {
                return true
            } else if (l > r) {
                return false
            }
        }
        return lhs.array.count < rhs.array.count
    }
    
}

class MemoryStorage: RawStorage {
    private var raw = SortedDictionary<BytesWrapper, BytesWrapper>()
    
    func get(key: BytesWrapper) -> Promise<BytesWrapper?>{
        return Promise(raw.findValue(for: key))
    }
    
    func range(from: BytesWrapper, to: BytesWrapper, inclusive: Bool) -> Promise<[BytesWrapper]> {
        var answers: [BytesWrapper] = []
        for key in raw.keys {
            if key < from || key > to {
                continue
            }
            if (!inclusive && key == to) {
                continue
            }
            if let value = raw.findValue(for: key) {
                answers.append(value)
            }
        }
        return Promise(answers)
    }
    
    func put(key: BytesWrapper, value: BytesWrapper) -> Promise<Void> {
        if raw.findValue(for: key) != nil {
            raw.update(value: value, for: key)
        } else {
            raw.insert(value: value, for: key)
        }
        
        return Promise(())
    }
    
    func remove(key: BytesWrapper) -> Promise<Void> {
        raw.removeValue(for: key)
        return Promise(())
    }
    
    // It's a lie.  We don't do anything transactionally.
    func transactionally(key: BytesWrapper, transaction: @escaping () -> Promise<Void>) -> Promise<Void> {
        return transaction()
    }
}
