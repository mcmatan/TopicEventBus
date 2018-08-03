//
//  TopicEventBusTests.swift
//  TopicEventBusTests
//
//  Created by Matan Cohen on 8/2/18.
//  Copyright © 2018 Matan. All rights reserved.
//

import XCTest
@testable import TopicEventBus

class SampleEvent: TopicEvnet {
    var value: String
    init(value: String) {
        self.value = value
    }
}

class SampleEventWithTopic: TopicEvnet {
    init(topic: String) {
        super.init()
        self.key = topic
    }
}

class FiringViewController: UIViewController {
    let topicEventBus: TopicEventBus
    
    init(topicEventBus: TopicEventBus) {
        self.topicEventBus = topicEventBus
        super.init(nibName: nil, bundle: nil)
        _ = self.topicEventBus.subscribe { (sampleEventWithTopic: SampleEventWithTopic) in
            //
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("I'm dead")
    }
}

class TopicEventBusTests: XCTestCase {
    let topicEventBus = TopicEventBus()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEventNoTopic() {
        let completedExpectation = expectation(description: "Completed")
        let sampleEvent = SampleEvent(value: "bla")

        _ = topicEventBus.subscribe { (sampleEvent: SampleEvent) in
            assert(sampleEvent.value == "bla")
            completedExpectation.fulfill()
        }
        topicEventBus.fire(event: sampleEvent)
        waitForExpectations(timeout: 6, handler: nil)
    }
    
    func testTopic() {
        let completedExpectation = expectation(description: "Completed")
        let sampleEvent = SampleEventWithTopic.init(topic: "1234")
        
        _ = topicEventBus.subscribe(topic: "1234") { (sampleEventWithTopic: SampleEventWithTopic) in
            assert(true)
            completedExpectation.fulfill()
        }
        
        topicEventBus.fire(event: sampleEvent)
        waitForExpectations(timeout: 6, handler: nil)
    }
    weak var vc: FiringViewController?
    func testDeinitOnSubscribers() {
        let completedExpectation = expectation(description: "Completed")
        vc = FiringViewController.init(topicEventBus: self.topicEventBus)
        DispatchQueue.main.async {
            DispatchQueue.main.async {
            XCTAssertNil(self.vc)
             completedExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 4, handler: nil)
    }
    
    func testStopEventsAfterStopListener() {
        let completedExpectation = expectation(description: "Completed")
        let sampleEvent = SampleEventWithTopic.init(topic: "1234")
        
        let listener = topicEventBus.subscribe(topic: "1234") { (sampleEventWithTopic: SampleEventWithTopic) in
            assert(true)
            completedExpectation.fulfill()
        }
        
        listener.stop()
        
        topicEventBus.fire(event: sampleEvent)
        waitForExpectations(timeout: 6, handler: nil)
    }
    
}
