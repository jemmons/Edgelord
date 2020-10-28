import Foundation



public protocol Scalar {
  var serialized: String {get}
}


extension Dictionary: Scalar where Key == ArgumentIdentifier, Value: Any {
  public var serialized: String {
    var buf = "{"
    let scalarValues = mapValues { ($0 as? Scalar) ?? String(describing: $0) }
    buf.append(scalarValues
                .keys
                .sorted() //Makes testing a lot easier.
                .map { "\($0): \(scalarValues[$0]!.serialized)"}
                .joined(separator: ", "))
    buf.append("}")
    return buf
  }
}


extension String: Scalar {
  public var serialized: String { return "\"" + self + "\"" }
}



extension Int: Scalar {
  public var serialized: String { return String(describing: self) }
}



extension Double: Scalar {
  public var serialized: String { return String(describing: self) }
}



extension Bool: Scalar {
  public var serialized: String { return self ? "true" : "false" }
}
