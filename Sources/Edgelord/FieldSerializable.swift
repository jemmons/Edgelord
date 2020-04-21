import Foundation



public protocol FieldSerializable {
  func serializeField(depth: Int) -> String
  func serializeAsChild(depth: Int) -> String
}



public extension FieldSerializable {
  func serializeAsChild(depth: Int) -> String {
    let indent = SerializationHelper.indentation(for: depth)
    var buf = ""
    buf.append(" {\n")
    buf.append(serializeField(depth: depth+1))
    buf.append(indent + "}")
    return buf
  }
    
  
  func merge(serializable: FieldSerializable) -> FieldSerializable {
    switch self {
    case let a as [FieldSerializable]:
      return a + [serializable]
    case is Empty:
      return serializable
    default:
      return [self, serializable]
    }
  }
}
