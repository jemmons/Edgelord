import Foundation



public struct Field: FieldSerializable {
  private var name: FieldIdentifier
  private var alias: String?
  private var arguments: [ArgumentIdentifier: Scalar]
  private var children: FieldSerializable
  
  
  public init(_ name: FieldIdentifier, alias: String? = nil, arguments: [ArgumentIdentifier: Scalar] = [:], children: FieldSerializable = Empty()) {
    self.name = name
    self.alias = alias
    self.arguments = arguments
    self.children = children
  }
  
  
  public init(_ name: FieldIdentifier, alias: String? = nil, arguments: [ArgumentIdentifier: Scalar] = [:], @FieldBuilder builder: () -> FieldSerializable) {
    self.init(name, alias: alias, arguments: arguments, children: builder())
  }
    
  
  public func serializeField(depth: Int = 0) -> String {
    var buf = ""
    
    let declaration = Helper.makeDeclaration(name: name, alias: alias, arguments: arguments)
    let indent = SerializationHelper.indentation(for: depth)

    buf.append(indent)
    buf.append(declaration)
    buf.append(children.serializeAsChild(depth: depth))
    buf.append("\n")
    
    return buf
  }
}



private enum Helper {
  static func makeDeclaration(name: String, alias: String?, arguments: [ArgumentIdentifier: Scalar]) -> String {
    var buffer = ""
    if let someAlias = alias {
      buffer.append("\(someAlias): ")
    }
    
    buffer.append(name)
    
    if !arguments.isEmpty {
      buffer.append("(")
      let args = arguments.keys.sorted().map { return "\($0): \(arguments[$0]!.serialized)" }
      buffer.append(args.joined(separator: ", "))
      buffer.append(")")
    }
    return buffer
  }
}
