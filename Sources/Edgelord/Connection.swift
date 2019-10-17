import Foundation



public struct Connection: FieldSerializable {
  private let field: Field
  private let pageInfo = Field("pageInfo") {
    FieldBuilder.buildBlock(
      Field("hasNextPage"),
      Field("hasPreviousPage"),
      Field("startCursor"),
      Field("endCursor")
    )
  }

  
  public enum Direction {
    case after(String), before(String)
  }
  
  
  public init(_ name: FieldIdentifier, pageSize: Int, page: Direction? = nil, alias: String? = nil, arguments: [ArgumentIdentifier: Scalar] = [:], children: [FieldSerializable] = []) {
    let pagedArguments: [ArgumentIdentifier: Scalar]
    switch page {
    case .after(let cursor):
      pagedArguments = ["first": pageSize, "after": cursor]
    case .before(let cursor):
      pagedArguments = ["last": pageSize, "before": cursor]
    case nil:
      pagedArguments = ["first": pageSize]
    }
    field = Field(name, alias: alias, arguments: pagedArguments.merging(arguments) { $1 }, children: children + [pageInfo])
  }
  
  
  public init(_ name: FieldIdentifier, pageSize: Int, page: Direction? = nil, alias: String? = nil, arguments: [ArgumentIdentifier: Scalar] = [:], buildChildren: () -> [FieldSerializable]) {
    self.init(name, pageSize: pageSize, page: page, alias: alias, arguments: arguments, children: buildChildren())
  }
  
  
  public func serializeField(depth: Int = 0) -> String {
    field.serializeField(depth: depth)
  }
}
