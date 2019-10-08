import Foundation



public struct Mutation: QuerySerializable {
  private let name: String?
  private let children: [Vertex]
  
  
  public init(_ name: String? = nil, children: [Vertex]) {
    self.name = name
    self.children = children
  }
  
  
  public init(_ name: String? = nil, buildChildren: () -> [Vertex]) {
    self.init(name, children: buildChildren())
  }
  
  
  public func makeQuery(depth: Int = 0) -> String {
    let indent = SerializationHelper.indentation(for: depth)
    var buf = indent
    buf.append("mutation ")
    if let someName = name {
      buf.append(someName)
      buf.append(" ")
    }
    buf.append("{\n")

    buf.append(SerializationHelper.group(for: children, depth: depth + 1))
    
    buf.append(indent + "}\n")
    return buf
  }
}

