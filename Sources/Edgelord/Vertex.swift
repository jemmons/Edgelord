import Foundation



public struct Vertex: QuerySerializable {
  private var name: VertexIdentifier?
  private var alias: String?
  private var arguments: [ArgumentIdentifier: Scalar]
  private var children: [Vertex]
  
  
  public init(_ name: VertexIdentifier, alias: String? = nil, arguments: [ArgumentIdentifier: Scalar] = [:], children: [Vertex] = []) {
    self.name = name
    self.alias = alias
    self.arguments = arguments
    self.children = children
  }
  
  
  public init(_ name: VertexIdentifier, alias: String? = nil, arguments: [ArgumentIdentifier: Scalar] = [:], buildChildren: () -> [Vertex]) {
    self.init(name, alias: alias, arguments: arguments, children: buildChildren())
  }
  
  
  public init(fragmentWithChildren children: [Vertex]) {
    name = nil
    alias = nil
    arguments = [:]
    self.children = children
  }
  
  
  public init(fragmentWithChildrenBuilder builder: () -> [Vertex]) {
    self.init(fragmentWithChildren: builder())
  }
  
  
  public func makeQuery(depth: Int = 0) -> String {
    let indent = SerializationHelper.indentation(for: depth)
    var buf = ""
    
    let declaration = Helper.makeDeclaration(name: name, alias: alias, arguments: arguments)
    
    switch (isFragment: declaration == nil, hasBody: !children.isEmpty) {
    case (isFragment: false, hasBody: true):
      buf.append(indent + declaration! + " {\n")
      buf.append(SerializationHelper.group(for: children, depth: depth + 1))
      buf.append(indent + "}\n")
    
    case (isFragment: false, hasBody: false):
      buf.append(indent + declaration! + "\n")
      
    case (isFragment: true, hasBody: true):
      buf.append(SerializationHelper.group(for: children, depth: depth))
      
    case (isFragment: true, hasBody: false):
      // Nonsensical, really. Just do nothing.
      break
    }

    return buf
  }
}



private enum Helper {
  static func makeDeclaration(name: String?, alias: String?, arguments: [ArgumentIdentifier: Scalar]) -> String? {
    guard let someName = name else {
      return nil
    }
    
    var buffer = ""
    if let someAlias = alias {
      buffer.append("\(someAlias): ")
    }
    
    buffer.append(someName)
    
    if !arguments.isEmpty {
      buffer.append("(")
      let args = arguments.keys.sorted().map { return "\($0): \(arguments[$0]!.serialized)" }
      buffer.append(args.joined(separator: ", "))
      buffer.append(")")
    }
    return buffer
  }
}
