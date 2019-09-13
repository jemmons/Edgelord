import Foundation


public protocol QuerySerializable {
  func makeQuery(depth: Int) -> String
}
