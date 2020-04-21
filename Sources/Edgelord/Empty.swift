import Foundation



public struct Empty: FieldSerializable {
  public init() { }
  
  
  public func serializeField(depth: Int) -> String {
    ""
  }

  
  public func serializeAsChild(depth: Int) -> String {
    ""
  }
}
