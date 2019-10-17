import Foundation



public struct Field: FieldSerializable {
  private var name: FieldIdentifier
  private var alias: String?
  private var arguments: [ArgumentIdentifier: Scalar]
  private var children: [FieldSerializable]
  
  
  public init(_ name: FieldIdentifier, alias: String? = nil, arguments: [ArgumentIdentifier: Scalar] = [:], children: [FieldSerializable] = []) {
    self.name = name
    self.alias = alias
    self.arguments = arguments
    self.children = children
  }
  
  
  public init(_ name: FieldIdentifier, alias: String? = nil, arguments: [ArgumentIdentifier: Scalar] = [:], buildChildren: () -> [FieldSerializable]) {
    self.init(name, alias: alias, arguments: arguments, children: buildChildren())
  }
  
  
  public func serializeField(depth: Int = 0) -> String {
    let indent = SerializationHelper.indentation(for: depth)
    var buf = ""
    
    let declaration = Helper.makeDeclaration(name: name, alias: alias, arguments: arguments)
    
    switch children.isEmpty {
    case true:
      buf.append(indent + declaration + "\n")

    case false:
      buf.append(indent + declaration + " {\n")
      buf.append(children.map { $0.serializeField(depth: depth+1) }.joined())
      buf.append(indent + "}\n")
    }
    
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
