import Foundation



public typealias VertexIdentifier = String
public typealias ArgumentIdentifier = String



public enum OperationType {
  case query(String), mutation(String), subscription(String)
}
