import Foundation




public struct Connection: FieldSerializable {
  private enum Const {
    static let pageInfo = Field("pageInfo") {
      Field("hasNextPage")
      Field("hasPreviousPage")
      Field("startCursor")
      Field("endCursor")
    }
  }
  private let field: Field

  
  public enum Direction {
    case after(String), before(String)
  }
  
  
  public init(_ name: FieldIdentifier, pageSize: Int, page: Direction? = nil, alias: String? = nil, arguments: [ArgumentIdentifier: Scalar] = [:], children: FieldSerializable = Empty()) {
    let pagedArguments: [ArgumentIdentifier: Scalar]
    switch page {
    case .after(let cursor):
      pagedArguments = ["first": pageSize, "after": cursor]
    case .before(let cursor):
      pagedArguments = ["last": pageSize, "before": cursor]
    case nil:
      pagedArguments = ["first": pageSize]
    }
    field = Field(name, alias: alias, arguments: pagedArguments.merging(arguments) { $1 }, children: (children.merge(serializable: Const.pageInfo)))
  }
  
  
  public init(_ name: FieldIdentifier, pageSize: Int, page: Direction? = nil, alias: String? = nil, arguments: [ArgumentIdentifier: Scalar] = [:], @FieldBuilder builder: () -> FieldSerializable) {
    self.init(name, pageSize: pageSize, page: page, alias: alias, arguments: arguments, children: builder())
  }

  
  public func serializeField(depth: Int = 0) -> String {
    field.serializeField(depth: depth)
  }
}
