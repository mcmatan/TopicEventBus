//
//  GeneralOutPutTests.swift
//  TopicEventBusTests
//
//  Created by Matan Cohen on 8/2/18.
//  Copyright © 2018 Matan. All rights reserved.
//

import XCTest

class GeneralOutPutTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let name = String(describing: GeneralOutPutTests.self)
        assert(name == "GeneralOutPutTests")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
