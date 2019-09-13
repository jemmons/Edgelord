import XCTest
import Edgelord



class OperationTests: XCTestCase {
  func testQueryOperationSerialization() {
    let subject = Operation(.query("MyName"), children: [])
    XCTAssertEqual(subject.makeQuery(), """
    query MyName {
    }
    
    """)
  }
  
  
  func testMutationOperationSerialization() {
    let subject = Operation(.mutation("Mutating"), children: [])
    XCTAssertEqual(subject.makeQuery(), """
    mutation Mutating {
    }
    
    """)
  }


  func testSubscriptionOperationSerialization() {
    let subject = Operation(.subscription("FuzzySub"), children: [])
    XCTAssertEqual(subject.makeQuery(), """
    subscription FuzzySub {
    }
    
    """)
  }
  
  
  func testOperationWithChildren() {
    let subject = Operation(.query("Mine")) {
      return VertexBuilder.buildBlock(
        Vertex("name"),
        Vertex("age"),
        Vertex("company") {
          return VertexBuilder.buildBlock(
            Vertex("name")
          )
        }
      )
    }
    
    XCTAssertEqual(subject.makeQuery(), """
    query Mine {
      name
      age
      company {
        name
      }
    }

    """)
  }
}
