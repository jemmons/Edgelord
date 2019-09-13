import Foundation



public protocol Scalar {
  var serialized: String {get}
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
