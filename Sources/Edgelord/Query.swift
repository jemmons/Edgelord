import Foundation



public struct Query {
  private let name: String?
  private let children: FieldSerializable
  
  
  public init(_ name: String? = nil, children: FieldSerializable) {
    self.name = name
    self.children = children
  }
  
  
  public init(_ name: String? = nil, @FieldBuilder builder: () -> FieldSerializable) {
    self.init(name, children: builder())
  }
  
  
  public func serialize() -> String {
    var buf = "query"
    if let someName = name {
      buf.append(" ")
      buf.append(someName)
    }
    buf.append(children.serializeAsChild(depth: 0))
    buf.append("\n")
    return buf
  }
}

