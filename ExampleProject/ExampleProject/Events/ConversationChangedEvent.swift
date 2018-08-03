//
//  ConversationChangedEvent.swift
//  ExampleProject
//
//  Created by Matan Cohen on 8/3/18.
//  Copyright © 2018 Matan. All rights reserved.
//

import Foundation
import TopicEventBus

class ConversationChangedEvent: TopicEvent {
    let newTitle: String
    init(conversationId: String, newTitle: String) {
        self.newTitle = newTitle
        super.init()
        self.key = conversationId
    }
}
