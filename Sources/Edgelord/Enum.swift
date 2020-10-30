import Foundation



public struct Enum: Scalar {
  private let value: String
  

  public init(_ value: String) {
    self.value = value
  }
  

  public var serialized: String {
    return value
  }
}
