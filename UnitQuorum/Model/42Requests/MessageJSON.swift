//
//  MessageJSON.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 6/16/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation

class MessageJSON: Decodable {
    let id: Int
    let author: Author
    let content: String
    var replies: [MessageJSON]?
    let created_at : String
    let updated_at : String
    let is_root : Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case content = "content"
        case replies = "replies"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case is_root = "is_root"
    }
    
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = (try values.decode(Int.self, forKey: .id))
        self.author = (try values.decode(Author.self, forKey: .author))
        self.content = (try values.decode(String.self, forKey: .content))
        self.created_at =  (try values.decode(String.self, forKey: .created_at))
        self.updated_at =  (try values.decode(String.self, forKey: .updated_at))
        self.is_root = (try values.decode(Bool.self, forKey: .is_root))
        self.replies = (try? values.decode([MessageJSON].self, forKey: .replies))
    }
}
