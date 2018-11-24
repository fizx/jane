import Promises
import Jane
import Swinject
import SwinjectAutoregistration
  
    
    class Example_UserRepository: Repository<Example_User> {
      
        // findOne
        func findById(_ key: String) -> Promise<Example_User?> {
          return self.storage.get(key: BytesWrapper(string: key)).then { (maybeBytes: BytesWrapper?) -> Example_User? in
            if let bytes = maybeBytes {
              return try! Example_User(serializedData: bytes.toData())
            } else {
              return nil
            }
          }
        }
        // findAllArray
        func findByIds(_ keys: [String]) -> Promise<[Example_User?]> {
          return all(keys.map{ findById($0)})
        }
        
        // findAllVariadic
        func findByIds(_ keys: String...) -> Promise<[Example_User?]> {
          return all(keys.map{ findById($0)})
        }
      
    }
    
    extension Example_User: StorageMappable {
      func toValue() -> BytesWrapper {
        return BytesWrapper(data: try! serializedData())
      } 
      func primaryIndex() -> BytesWrapper? {
        
          return BytesWrapper(string: self.id)
        
      }
      func secondaryIndexes() -> [Index: BytesWrapper] {
        return [:]
      }
      
      static func repository() -> Example_UserRepository.Type {
        return Example_UserRepository.self
      }
    }
    
    
    class Example_AccountRepository: Repository<Example_Account> {
      
        // findOne
        func findById(_ key: String) -> Promise<Example_Account?> {
          return self.storage.get(key: BytesWrapper(string: key)).then { (maybeBytes: BytesWrapper?) -> Example_Account? in
            if let bytes = maybeBytes {
              return try! Example_Account(serializedData: bytes.toData())
            } else {
              return nil
            }
          }
        }
        // findAllArray
        func findByIds(_ keys: [String]) -> Promise<[Example_Account?]> {
          return all(keys.map{ findById($0)})
        }
        
        // findAllVariadic
        func findByIds(_ keys: String...) -> Promise<[Example_Account?]> {
          return all(keys.map{ findById($0)})
        }
      
    }
    
    extension Example_Account: StorageMappable {
      func toValue() -> BytesWrapper {
        return BytesWrapper(data: try! serializedData())
      } 
      func primaryIndex() -> BytesWrapper? {
        
          return BytesWrapper(string: self.id)
        
      }
      func secondaryIndexes() -> [Index: BytesWrapper] {
        return [:]
      }
      
      static func repository() -> Example_AccountRepository.Type {
        return Example_AccountRepository.self
      }
    }
    
    
    class Example_PhotoRepository: Repository<Example_Photo> {
      
        // findOne
        func findById(_ key: String) -> Promise<Example_Photo?> {
          return self.storage.get(key: BytesWrapper(string: key)).then { (maybeBytes: BytesWrapper?) -> Example_Photo? in
            if let bytes = maybeBytes {
              return try! Example_Photo(serializedData: bytes.toData())
            } else {
              return nil
            }
          }
        }
        // findAllArray
        func findByIds(_ keys: [String]) -> Promise<[Example_Photo?]> {
          return all(keys.map{ findById($0)})
        }
        
        // findAllVariadic
        func findByIds(_ keys: String...) -> Promise<[Example_Photo?]> {
          return all(keys.map{ findById($0)})
        }
      
    }
    
    extension Example_Photo: StorageMappable {
      func toValue() -> BytesWrapper {
        return BytesWrapper(data: try! serializedData())
      } 
      func primaryIndex() -> BytesWrapper? {
        
          return BytesWrapper(string: self.id)
        
      }
      func secondaryIndexes() -> [Index: BytesWrapper] {
        return [:]
      }
      
      static func repository() -> Example_PhotoRepository.Type {
        return Example_PhotoRepository.self
      }
    }
    
    
    class Example_HelloRequestRepository: Repository<Example_HelloRequest> {
      
    }
    
    extension Example_HelloRequest: StorageMappable {
      func toValue() -> BytesWrapper {
        return BytesWrapper(data: try! serializedData())
      } 
      func primaryIndex() -> BytesWrapper? {
        
          return nil
        
      }
      func secondaryIndexes() -> [Index: BytesWrapper] {
        return [:]
      }
      
      static func repository() -> Example_HelloRequestRepository.Type {
        return Example_HelloRequestRepository.self
      }
    }
    
    
    class Example_HelloResponseRepository: Repository<Example_HelloResponse> {
      
    }
    
    extension Example_HelloResponse: StorageMappable {
      func toValue() -> BytesWrapper {
        return BytesWrapper(data: try! serializedData())
      } 
      func primaryIndex() -> BytesWrapper? {
        
          return nil
        
      }
      func secondaryIndexes() -> [Index: BytesWrapper] {
        return [:]
      }
      
      static func repository() -> Example_HelloResponseRepository.Type {
        return Example_HelloResponseRepository.self
      }
    }
  



  class Example_Binder {
    static func bind(_ container: Container) {
      
        container.autoregister(Example_UserRepository.self, initializer: Example_UserRepository.init)
      
        container.autoregister(Example_AccountRepository.self, initializer: Example_AccountRepository.init)
      
        container.autoregister(Example_PhotoRepository.self, initializer: Example_PhotoRepository.init)
      
        container.autoregister(Example_HelloRequestRepository.self, initializer: Example_HelloRequestRepository.init)
      
        container.autoregister(Example_HelloResponseRepository.self, initializer: Example_HelloResponseRepository.init)
      
    }
  }
