import XCTest
import Edgelord



class ConnectionTests: XCTestCase {
  func testMinimal() {
    let subject = Connection("testConnection", pageSize: 42).serializeField()
    XCTAssertEqual(subject, """
    testConnection(first: 42) {
      pageInfo {
        hasNextPage
        hasPreviousPage
        startCursor
        endCursor
      }
    }

    """)
  }
  
  
  func testMaximal() {
    let subject = Connection("testConnection", pageSize: 42, page: .after("XYZ"), alias: "myConnection", arguments: ["foo":"bar"]).serializeField()
    XCTAssert(subject.hasPrefix("myConnection: testConnection("))
    XCTAssert(subject.hasSuffix("""
    ) {
      pageInfo {
        hasNextPage
        hasPreviousPage
        startCursor
        endCursor
      }
    }

    """))
    
    XCTAssert(subject.contains("first: 42"))
    XCTAssert(subject.contains("after: \"XYZ\""))
    XCTAssert(subject.contains("foo: \"bar\""))
  }
  
  
  func testNesting() {
    let subject = Connection("connection", pageSize: 42) {
      FieldBuilder.buildBlock(
        Field("foo"),
        Connection("bar", pageSize: 64)
      )
    }.serializeField()
    
    XCTAssertEqual(subject, """
    connection(first: 42) {
      foo
      bar(first: 64) {
        pageInfo {
          hasNextPage
          hasPreviousPage
          startCursor
          endCursor
        }
      }
      pageInfo {
        hasNextPage
        hasPreviousPage
        startCursor
        endCursor
      }
    }

    """)
  }
  
  
  func testPageInfo() {
    let subject = Connection("connection", pageSize: 42).serializeField()
    
    XCTAssertEqual(subject, """
    connection(first: 42) {
      pageInfo {
        hasNextPage
        hasPreviousPage
        startCursor
        endCursor
      }
    }

    """)
  }
  
  
  func testNestedPageInfo() {
    let subject = Connection("connection", pageSize: 42) {
      FieldBuilder.buildBlock(
        Field("foo")
      )
    }.serializeField()
    
    XCTAssertEqual(subject, """
    connection(first: 42) {
      foo
      pageInfo {
        hasNextPage
        hasPreviousPage
        startCursor
        endCursor
      }
    }

    """)
  }
}
