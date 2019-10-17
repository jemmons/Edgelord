import XCTest
import Edgelord



class FieldTests: XCTestCase {
  func testNameSerialization() {
    let subject = Field("name")
    XCTAssertEqual(subject.serializeField(), "name\n")
  }
  
  
  func testAliasSerialization() {
    let subject = Field("name", alias: "MyAlias")
    XCTAssertEqual(subject.serializeField(), "MyAlias: name\n")
  }
  
  
  func testArgumentSerialization() {
    let subject = Field("name", arguments: [
      "string": "string",
      "integer": 42,
      "float": 3.14,
      "bool": true
    ])
    
    XCTAssertEqual(subject.serializeField(), """
    name(bool: true, float: 3.14, integer: 42, string: "string")

    """)
  }
  
  
  func testChildrenSerialization() {
    let subject = Field("hero") {
      return FieldBuilder.buildBlock(
        Field("name"),
        Field("age")
      )
    }
    
    XCTAssertEqual(subject.serializeField(), """
    hero {
      name
      age
    }

    """)
  }
  
  
  func testNestedSerialization() {
    let subject = Field("hero", alias: "MyHero") {
      FieldBuilder.buildBlock(
        Field("name"),
        Field("age"),
        Field("company") {
          FieldBuilder.buildBlock(
            Field("name"),
            Field("address", arguments: ["location": "primary"])
          )
        }
      )
    }
    
    XCTAssertEqual(subject.serializeField(), """
    MyHero: hero {
      name
      age
      company {
        name
        address(location: "primary")
      }
    }

    """)
  }  
}
