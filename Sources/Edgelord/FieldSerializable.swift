import Foundation


public protocol FieldSerializable {
  func serializeField(depth: Int) -> String
}
