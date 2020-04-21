import Foundation



public struct Subscription {
  private let name: String?
  private let children: FieldSerializable
  
  
  public init(_ name: String? = nil, children: FieldSerializable) {
    self.name = name
    self.children = children
  }
  
  
  public init(_ name: String? = nil, @FieldBuilder builder: () -> FieldSerializable) {
    #warning("As of Swift 5.2, a `builder` with a single expression will be evaliated directly (as an implicit return closure) rather than sent as an argument to `FieldBuilder.buildBlock(_:)`.")
    self.init(name, children: builder())
  }
  
  
  public func serialize() -> String {
    var buf = "subscription"
    if let someName = name {
      buf.append(" ")
      buf.append(someName)
    }
    buf.append(children.serializeAsChild(depth: 0))
    buf.append("\n")
    return buf
  }
}


