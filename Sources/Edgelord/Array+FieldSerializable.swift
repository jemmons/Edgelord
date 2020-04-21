import Foundation



extension Array: FieldSerializable where Element == FieldSerializable {
  public func serializeField(depth: Int) -> String {
    map { $0.serializeField(depth: depth) }.joined()
  }
}
