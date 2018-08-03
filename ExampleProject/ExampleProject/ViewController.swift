//
//  ViewController.swift
//  ExampleProject
//
//  Created by Matan Cohen on 8/3/18.
//  Copyright © 2018 Matan. All rights reserved.
//

import UIKit
import TopicEventBus

class ViewController: UIViewController {
    let topicEventBus = TopicEventBus.init()
    let conversationId = "1234"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = self.topicEventBus.subscribe { (conversationChangedEvent: ConversationChangedEvent) in
            let conversationKey = conversationChangedEvent.key ?? "No key"
            print("Any conversation changed event. key = \(conversationKey) new title = \(conversationChangedEvent.newTitle)")
        }
        
        let listener = self.topicEventBus.subscribe(topic: conversationId, callback: { (conversationChangedEvent: ConversationChangedEvent) in
            //
        })
        listener.stop()
        
        self.topicEventBus.fire(event: ConversationChangedEvent.init(conversationId: "1234", newTitle: "First update"))
        self.topicEventBus.fire(event: ConversationChangedEvent.init(conversationId: "123456",  newTitle: "Second update"))
        
        self.topicEventBus.terminate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


