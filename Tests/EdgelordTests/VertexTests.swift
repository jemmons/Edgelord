import XCTest
import Edgelord



class VertexTests: XCTestCase {
  func testNameSerialization() {
    let subject = Vertex("name")
    XCTAssertEqual(subject.makeQuery(), "name\n")
  }
  
  
  func testAliasSerialization() {
    let subject = Vertex("name", alias: "MyAlias")
    XCTAssertEqual(subject.makeQuery(), "MyAlias: name\n")
  }
  
  
  func testArgumentSerialization() {
    let subject = Vertex("name", arguments: [
      "string": "string",
      "integer": 42,
      "float": 3.14,
      "bool": true
    ])
    
    XCTAssertEqual(subject.makeQuery(), """
    name(bool: true, float: 3.14, integer: 42, string: "string")

    """)
  }
  
  
  func testChildrenSerialization() {
    let subject = Vertex("hero") {
      return VertexBuilder.buildBlock(
        Vertex("name"),
        Vertex("age")
      )
    }
    
    XCTAssertEqual(subject.makeQuery(), """
    hero {
      name
      age
    }

    """)
  }
  
  
  func testNestedSerialization() {
    let subject = Vertex("hero", alias: "MyHero") {
      return VertexBuilder.buildBlock(
        Vertex("name"),
        Vertex("age"),
        Vertex("company") {
          return VertexBuilder.buildBlock(
            Vertex("name"),
            Vertex("address", arguments: ["location": "primary"])
          )
        }
      )
    }
    
    XCTAssertEqual(subject.makeQuery(), """
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
  
  func testFragment() {
    let companyFragment = Vertex {
      return VertexBuilder.buildBlock(
        Vertex("name"),
        Vertex("address", arguments: ["location": "primary"])
      )
    }
    
    let subject = Vertex("hero", alias: "MyHero") {
      return VertexBuilder.buildBlock(
        Vertex("name"),
        Vertex("age"),
        Vertex("company") {
          return VertexBuilder.buildBlock(
            companyFragment
          )
        }
      )
    }
    
    XCTAssertEqual(subject.makeQuery(), """
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
