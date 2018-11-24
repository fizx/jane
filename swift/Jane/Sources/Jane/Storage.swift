import Algorithm
import Foundation

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
    func get(key: BytesWrapper, handler: @escaping (BytesWrapper?) -> ())
    func range(from: BytesWrapper, to: BytesWrapper, inclusive: Bool, handler: @escaping ([BytesWrapper]) -> ())
    func put(key: BytesWrapper, value: BytesWrapper, handler: @escaping () -> ())
    func remove(key: BytesWrapper, handler: @escaping () -> ())
    func transactionally(key: BytesWrapper, transaction: @escaping () -> (), handler: @escaping () -> ())
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
    
    func get(key: BytesWrapper, handler: @escaping (BytesWrapper?) -> ()) {
        handler(raw.findValue(for: key))
    }
    
    func range(from: BytesWrapper, to: BytesWrapper, inclusive: Bool = false, handler: @escaping ([BytesWrapper]) -> ()) {
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
        handler(answers)
    }
    
    func put(key: BytesWrapper, value: BytesWrapper, handler: @escaping () -> ()) {
        raw.update(value: value, for: key)
        handler()
    }
    
    func remove(key: BytesWrapper, handler: @escaping () -> ()) {
        raw.removeValue(for: key)
        handler()
    }
    
    // It's a lie.  We don't do anything transactionally.
    func transactionally(key: BytesWrapper, transaction: @escaping () -> (), handler: @escaping () -> ()) {
        transaction()
        handler()
    }
}
