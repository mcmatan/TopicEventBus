# TopicEventBus
Pub/Sub design pattern implementation framework, with ability to publish events by topic.


[![Pod version](https://img.shields.io/cocoapods/v/TopicEventBus.svg?style=flat)](http://cocoadocs.org/docsets/EasyList)
[![Language](https://img.shields.io/badge/language-swift-orange.svg?style=flat)](https://developer.apple.com/swift)

<p align = "center"><img src="https://image.ibb.co/ixFt0e/logo_transparent.png" alt="TopicEventBus Icon"/></p>

## About:

TopicEventBus is an Easy to use, type safe, way of implementing the Pub/Sub pattern.
There are many other libraries out there, aiming to solve this issue, but none can support publishing events by topic, in a type-safe way, with no magic strings.

## Show me this code, and what's in it for me.

Le'ts build a chat app.
In this app, we would are going to have multiple conversations screens, each one of them would like to know only about changes for It's conversation.

First step, create event for conversation update:

```Swift
class ConversationChangedEvent: TopicEvnet {
    let newTitle: String
    init(conversationId: String, newTitle: String) {
        self.newTitle = newTitle
        super.init()
        self.key = conversationId
    }
}
```

Every event must inharit from "TopicEvnet", and in case it has a topic (Our example it will be the conversation id) set "key" property to the correct value.

Now inside Conversation vc, subscribe to this event:

```Swift
class ConversationVC: UIViewController {
    let topicEventBus: TopicEventBus
    let conversationId = "1234"
    
    init(topicEventBus: TopicEventBus) {
        self.topicEventBus = topicEventBus
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = self.topicEventBus.subscribe(topic: conversationId, callback: { (conversationChangedEvent: ConversationChangedEvent) in
            // This will run every time "ConversationChangedEvent" with id 1234 will be fired.
        })
    }
}
```

This is how you fire an event:

```Swift

class FiringService {
    let topicEventBus: TopicEventBus
    init(topicEventBus: TopicEventBus) {
        self.topicEventBus = topicEventBus
    }
    
    func conversationTitleChanged() {
        self.topicEventBus.fire(event: ConversationChangedEvent.init(conversationId: "1234", newTitle: "First update"))
    }
}
```

And you did it! You fired your first event with topic!

## API 

If you subscribe to event and specify no topic, you will receive all events from that type, no matter their key:

```Swift
_ = self.topicEventBus.subscribe { (conversationChangedEvent: ConversationChangedEvent) in
  // All events from this type: ConversationChangedEvent will trigger this block
}
```

Unsubscribe by calling "stop" on the returned object on subscribe:

```Swift
let listener = self.topicEventBus.subscribe(topic: conversationId, callback: { (conversationChangedEvent: ConversationChangedEvent) in
            //
})
listener.stop()        
```

On log out, you can terminate by just calling:

```Swift
self.topicEventBus.terminate()
```


## Example project

Please notice example project contains tests to support all edge cases, plus example code from the above snippets.

## Installation

#### Cocoapods
**TopicEventBus** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TopicEventBus'
```

#### Manually
1. Download and drop ```/TopicEventBus``` folder in your project.  
2. Congratulations!  

## Author

[Matan](https://github.com/mcmatan) made this with ❤️.
