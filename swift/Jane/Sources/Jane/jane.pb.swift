import Jane
import Swinject
import SwinjectAutoregistration
  
    
    class Example_UserRepository: Repository {
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
    
    
    class Example_AccountRepository: Repository {
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
    
    
    class Example_PhotoRepository: Repository {
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
  



  class Example_Binder {
    static func bind(_ container: Container) {
      
        container.autoregister(Example_UserRepository.self, initializer: Example_UserRepository.init)
      
        container.autoregister(Example_AccountRepository.self, initializer: Example_AccountRepository.init)
      
        container.autoregister(Example_PhotoRepository.self, initializer: Example_PhotoRepository.init)
      
    }
  }
