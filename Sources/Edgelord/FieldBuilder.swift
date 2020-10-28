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
    return child
  }
  
  
  public static func buildOptional(_ component: FieldSerializable?) -> FieldSerializable {
    return component ?? Empty()
  }
  
  
  public static func buildEither(first component: FieldSerializable) -> FieldSerializable {
    return component
  }
    
    
  public static func buildEither(second component: FieldSerializable) -> FieldSerializable {
    return component
  }
}
