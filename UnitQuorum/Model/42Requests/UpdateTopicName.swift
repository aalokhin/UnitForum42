//
//  UpdateTopicName.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 6/30/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation

//"topic": {
//    "name": "The daily unicorn #837 🦄"
//}

class TopicName : Encodable
{
    let name : String
    
    init(name : String) {
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
    
}

class TopicUpdJSON : Encodable
{
    let topic : TopicName
    
    init(topic : TopicName) {
        self.topic = topic
    }
    
    enum CodingKeys: String, CodingKey {
        case topic = "topic"
    }
}
