//
//  Subscribtion.swift
//  TopicEventBus
//
//  Created by Matan Cohen on 8/3/18.
//  Copyright © 2018 Matan. All rights reserved.
//

import Foundation
class Subscription: Listener {
    let key: String?
    var subscriber: ((Any) -> Void)?
    init(key: String?, subscriber: @escaping (Any) -> Void) {
        self.key = key
        self.subscriber = subscriber
    }
    func stop() {
        subscriber = nil
    }
}
