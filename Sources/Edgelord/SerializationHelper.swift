import Foundation



internal enum SerializationHelper {
  private static let indentCharacter = "  "
  static func indentation(for depth: Int) -> String {
    return Array(repeating: indentCharacter, count: depth).joined()
  }
}
