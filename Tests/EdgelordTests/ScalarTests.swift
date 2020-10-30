import XCTest
import Edgelord



public class ScalarTests: XCTestCase {
  func testStrings() {
    XCTAssertEqual("thing".serialized, "\"thing\"")
  }

  
  func testObjects() {
    XCTAssertEqual(["bool": false, "num": 42, "str": "str"].serialized, "{bool: false, num: 42, str: \"str\"}")
  }
  
  
  func testEnums() {
    let UP = Enum("UP")
    let DOWN = Enum("DOWN")
    XCTAssertEqual(UP.serialized, "UP")
    XCTAssertEqual(DOWN.serialized, "DOWN")
  }
}
