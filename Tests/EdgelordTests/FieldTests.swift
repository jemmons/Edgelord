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
  
  
  func testSingleChildSerialization() {
    let subject = Field("hero") {
      Field("name")
    }
    
    XCTAssertEqual(subject.serializeField(), """
    hero {
      name
    }

    """)
  }

  
  func testMultipleChildrenSerialization() {
    let subject = Field("hero") {
      Field("name")
      Field("age")
    }
    
    XCTAssertEqual(subject.serializeField(), """
    hero {
      name
      age
    }

    """)
  }
  
  
  func testNestedMultipleSerialization() {
    let subject = Field("hero", alias: "MyHero") {
      Field("name")
      Field("age")
      Field("company") {
        Field("name")
        Field("address", arguments: ["location": "primary"])
      }
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
  
  
  func testNestedSingleSerialization() {
    let subject = Field("hero", alias: "MyHero") {
      Field("company") {
        Field("name")
      }
    }
    
    XCTAssertEqual(subject.serializeField(), """
    MyHero: hero {
      company {
        name
      }
    }

    """)
  }
}
