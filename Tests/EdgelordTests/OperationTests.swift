import XCTest
import Edgelord



class OperationTests: XCTestCase {
  func testQueryOperationSerialization() {
    let subject = Query("MyName", children: [])
    XCTAssertEqual(subject.makeQuery(), """
    query MyName {
    }
    
    """)
  }
  
  
  func testMutationOperationSerialization() {
    let subject = Mutation("Mutating", children: [])
    XCTAssertEqual(subject.makeQuery(), """
    mutation Mutating {
    }
    
    """)
  }


  func testSubscriptionOperationSerialization() {
    let subject = Subscription("FuzzySub", children: [])
    XCTAssertEqual(subject.makeQuery(), """
    subscription FuzzySub {
    }
    
    """)
  }
  
  
  func testOperationWithChildren() {
    let subject = Query("Mine") {
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
