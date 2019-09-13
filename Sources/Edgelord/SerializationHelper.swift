import Foundation



internal enum SerializationHelper {
  private static let indentCharacter = "  "
  static func indentation(for depth: Int) -> String {
    var buf = ""
    for _ in 0..<depth {
      buf.append(indentCharacter)
    }
    return buf
  }
  
  
  static func group(for collection: [QuerySerializable], depth: Int) -> String {
    return collection.map { $0.makeQuery(depth: depth) }.joined()
  }
}
