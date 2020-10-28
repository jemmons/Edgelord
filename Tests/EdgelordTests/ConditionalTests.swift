import XCTest
import Edgelord



class ConditionalTests: XCTestCase {
  func testIf() {
    var polite = true

    let politeSubject = Query("Mine") {
      Field("name")
      if !polite {
        Field("age")
      }
    }
    XCTAssertEqual(politeSubject.serialize(), """
    query Mine {
      name
    }

    """)

    polite = false
    let impoliteSubject = Query("Mine") {
      Field("name")
      if !polite {
        Field("age")
      }
    }
    XCTAssertEqual(impoliteSubject.serialize(), """
    query Mine {
      name
      age
    }

    """)
  }
  
  
  func testIfElse() {
    var polite = true

    let politeSubject = Query("Mine") {
      Field("name")
      if polite {
        Field("experience")
      } else {
        Field("age")
      }
    }
    XCTAssertEqual(politeSubject.serialize(), """
    query Mine {
      name
      experience
    }

    """)

    polite = false
    let impoliteSubject = Query("Mine") {
      Field("name")
      if polite {
        Field("experience")
      } else {
        Field("age")
      }
    }
    XCTAssertEqual(impoliteSubject.serialize(), """
    query Mine {
      name
      age
    }

    """)
  }
  
  
  func testSwitch() {
    enum Knight {
      case arthur, lancelot, robin
    }
    var knight = Knight.arthur
    let arthur = Query("About") {
      Field("name")
      Field("quest")
      switch knight {
      case .arthur:
        Field("vOfSwallow")
      case .lancelot:
        Field("favoriteColor")
      case .robin:
        Field("assyriaCapital")
      }
    }

    knight = .lancelot
    let lancelot = Query("About") {
      Field("name")
      Field("quest")
      switch knight {
      case .arthur:
        Field("vOfSwallow")
      case .lancelot:
        Field("favoriteColor")
      case .robin:
        Field("assyriaCapital")
      }
    }
    
    knight = .robin
    let robin = Query("About") {
      Field("name")
      Field("quest")
      switch knight {
      case .arthur:
        Field("vOfSwallow")
      case .lancelot:
        Field("favoriteColor")
      case .robin:
        Field("assyriaCapital")
      }
    }

    
    
    XCTAssertEqual(arthur.serialize(), """
    query About {
      name
      quest
      vOfSwallow
    }

    """)
    XCTAssertEqual(lancelot.serialize(), """
    query About {
      name
      quest
      favoriteColor
    }

    """)
    XCTAssertEqual(robin.serialize(), """
    query About {
      name
      quest
      assyriaCapital
    }

    """)

  }
}
