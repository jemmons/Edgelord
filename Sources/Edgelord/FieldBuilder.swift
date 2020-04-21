import Foundation



@_functionBuilder
public class FieldBuilder {
  public static func buildBlock(_ children: FieldSerializable...) -> FieldSerializable {
    guard !children.isEmpty else {
      return Empty()
    }
    return children
  }


  public static func buildBlock(_ child: FieldSerializable) -> FieldSerializable {
    #warning("As of Swift 5.2, this is never executed. The given single-expression closure is evaluated as having an implicit return, instead.")
    return child
  }
}
