//
//  TopicPostJSON.swift
//  UnitQuorum
//
//  Created by ANASTASIA on 6/17/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation

class TopicPostJSON : Encodable
{
    let topic: TopicToSend
    
    init(topic : TopicToSend) {
        self.topic = topic
    }
    
    enum CodingKeys: String, CodingKey {
        case topic = "topic"
    }
}
