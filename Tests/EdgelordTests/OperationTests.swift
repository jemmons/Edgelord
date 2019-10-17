import XCTest
import Edgelord



class OperationTests: XCTestCase {
  func testQueryOperationSerialization() {
    let subject = Query("MyName", children: [])
    XCTAssertEqual(subject.serialize(), """
    query MyName {
    }
    
    """)
  }
  
  
  func testMutationOperationSerialization() {
    let subject = Mutation("Mutating", children: [])
    XCTAssertEqual(subject.serialize(), """
    mutation Mutating {
    }
    
    """)
  }


  func testSubscriptionOperationSerialization() {
    let subject = Subscription("FuzzySub", children: [])
    XCTAssertEqual(subject.serialize(), """
    subscription FuzzySub {
    }
    
    """)
  }
  
  
  func testOperationWithChildren() {
    let subject = Query("Mine") {
      return FieldBuilder.buildBlock(
        Field("name"),
        Field("age"),
        Field("company") {
          return FieldBuilder.buildBlock(
            Field("name")
          )
        }
      )
    }
    
    XCTAssertEqual(subject.serialize(), """
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
