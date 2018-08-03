# TopicEventBus
Pub/Sub design pattern implementation framework, with ability to publish events by topic.

[![Language](https://img.shields.io/badge/language-swift-orange.svg?style=flat)](https://developer.apple.com/swift)

<p align = "center"><img src="https://image.ibb.co/ixFt0e/logo_transparent.png" alt="TopicEventBus Icon"/></p>

## About:

TopicEventBus is Easy to use, type safe way of implementing Pub/Sub pattern.

There are many other libraries out there, aiming to solve this issue, but none of them support publishing events by topic, in a type-safe way, with no magic strings.

Also, TopicEventBus holds weak referenced for Its observers, so you don't have to be afraid of memory leaks.

## What is a topic?

The topic is for example, when you would like to publish "ConversationUpdateEvent" yet have the ability to publish that event only to listeners with conversation id "1234" or to all listeners.
Specifying the conversation Id is specifying a topic for that event.

## Show me the code! and what's in it for me.

Le'ts build a chat app!

In this app, we are going to have multiple conversations screens, each one of them would like to know only about changes to Its own conversation.

The first step, create an event for conversation update:

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

Every event must inherit from "TopicEvnet," and in case it has a topic (Our example it will be the conversation id) set "key" property to the correct value.

Now inside ConversationVC, subscribe to this event:

*Notice you only need to specify the return value you are excpeting, for TopicEventBus to figger out the event you are subscribing for*

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
        self.topicEventBus.fire(event: ConversationChangedEvent.init(conversationId: "1234",
                                                                                            newTitle: "First update"))
    }
}
```

You did it! You fired your first event with topic  🤗 🎉

## API 

If you subscribe to event and specify no topic, you will receive all events from that type, no matter their key:

```Swift
_ = self.topicEventBus.subscribe { (conversationChangedEvent: ConversationChangedEvent) in
  // All events from this type: ConversationChangedEvent will trigger this block
}
```

Unsubscribe by calling "stop" on the returned object after subscribing:

```Swift
let listener = self.topicEventBus.subscribe(topic: conversationId, callback: { (conversationChangedEvent: ConversationChangedEvent) in
            //
})
listener.stop()        
```

On app log out, terminate TopicEventBus by just calling:

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
