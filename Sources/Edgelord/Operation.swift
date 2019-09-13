import Foundation



public struct Operation: QuerySerializable {
  private let type: OperationType
  private let children: [Vertex]
  
  
  public init(_ type: OperationType, children: [Vertex]) {
    self.type = type
    self.children = children
  }
  
  
  public init(_ type: OperationType, buildChildren: () -> [Vertex]) {
    self.init(type, children: buildChildren())
  }
  
  
  public func makeQuery(depth: Int = 0) -> String {
    let indent = SerializationHelper.indentation(for: depth)
    var buf = indent
    
    switch type {
    case .query(let name):
      buf.append("query \(name) {\n")
    case .mutation(let name):
      buf.append("mutation \(name) {\n")
    case .subscription(let name):
      buf.append("subscription \(name) {\n")
    }
    
    buf.append(SerializationHelper.group(for: children, depth: depth + 1))
    
    buf.append(indent + "}\n")
    return buf
  }
}

