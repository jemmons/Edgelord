import Foundation



public struct Mutation {
  private let name: String?
  private let children: [FieldSerializable]
  
  
  public init(_ name: String? = nil, children: [FieldSerializable]) {
    self.name = name
    self.children = children
  }
  
  
  public init(_ name: String? = nil, @FieldBuilder builder: () -> [FieldSerializable]) {
    #warning("As of Swift 5.2, a `builder` with a single expression will be evaliated directly (as an implicit return closure) rather than sent as an argument to `FieldBuilder.buildBlock(_:)`.")
    self.init(name, children: builder())
  }
  
  
  public func serialize() -> String {
    var buf = "mutation "
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

