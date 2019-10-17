import Foundation



public struct Query {
  private let name: String?
  private let children: [FieldSerializable]
  
  
  public init(_ name: String? = nil, children: [FieldSerializable]) {
    self.name = name
    self.children = children
  }
  
  
  public init(_ name: String? = nil, buildChildren: () -> [FieldSerializable]) {
    self.init(name, children: buildChildren())
  }
  
  
  public func serialize() -> String {
    var buf = "query "
    if let someName = name {
      buf.append(someName)
      buf.append(" ")
    }
    buf.append("{\n")

    buf.append(children.map { $0.serializeField(depth: 1) }.joined())
    
    buf.append("}\n")
    return buf
  }
}

