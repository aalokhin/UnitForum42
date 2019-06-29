//
//  PostMessage.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 6/29/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation



//POST /v2/messages
//POST "v2/topics/\(topicId)/messages?message[author_id]=\(authorId)&message[content]=\(content)"


/*
 
 POST /v2/messages
 {
         "message": {
         "author_id": "6",
         "content": "Hello world",
         "messageable_id": "7",
         "messageable_type": "Topic"
        }
}
 201
 {
         "id": 101,
             "author": {
             "id": 6,
             "login": "qbollach",
             "url": "https://api.intra.42.fr/v2/users/qbollach"
         },
             "content": "Hello world",
             "content_html": null,
             "replies": [],
             "created_at": "2017-11-22T13:43:46.084Z",
             "updated_at": "2017-11-22T13:43:46.084Z",
             "parent_id": null,
             "is_root": false,
             "messageable_id": 7,
             "messageable_type": "Topic",
             "votes_count": {
             "upvote": 0,
             "downvote": 0,
             "trollvote": 0,
             "problem": 0
         },
         "user_votes": {
             "upvote": false,
             "downvote": false,
             "trollvote": false,
             "problem": false
         },
         "readings": 0
 }
 
 */


class PostMessage : Encodable{
    let message: MessageToSend
    
    init(message : MessageToSend) {
        self.message = message
    }
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}

class MessageToSend : Encodable{
//    "author_id": "6",
//    "content": "Hello world",
//    "messageable_id": "7",
//    "messageable_type": "Topic"
    
    
}
