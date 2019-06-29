//
//  TopicJSON.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 6/1/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation

func convertDate(dateStr : String) -> Date
{
    //let isoDate = "2016-04-14T10:44:00+0000"
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
    
    // set locale to reliable US_POSIX
    let retDate = dateFormatter.date(from : dateStr)!
    return retDate
    
}

class TopicJSON: Decodable {
        let id : Int
        let name : String
        let message: Message
        let author : Author
    
    let created_at : String
    let updated_at : String
    // IMportant ====================+> we have to convert it to StrDateing later with convertDate
//       let created_at : Date
//       let updated_at : Date
    
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
           case created_at = "created_at"
           case updated_at = "updated_at"
            case message = "message"
            case author = "author"
        }
    
    required init(from decoder: Decoder) throws {
        //  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Decodes the unkeyed array of self objects !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = (try values.decode(Int.self, forKey: .id))
        self.name = (try values.decode(String.self, forKey: .name))
        
       self.message = (try values.decode(Message.self, forKey: .message))
    
        
        self.created_at = (try values.decode(String.self, forKey: .created_at))
        self.updated_at = (try values.decode(String.self, forKey: .updated_at))
        self.author =  (try values.decode(Author.self, forKey: .author))
    }
        
    
}

class Message: Decodable {
    
    let id : Int
    let content: Content
    
    enum CodingKeys: String, CodingKey {
        case id, content
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = (try values.decode(Int.self, forKey: .id))
        self.content = (try values.decode(Content.self, forKey: .content))
    }
}


class Content: Decodable {
    let markdown: String?
    let html: String?
    
    enum CodingKeys: String, CodingKey {
        case markdown, html
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.markdown = (try? values.decode(String.self, forKey: .markdown))
        self.html = (try? values.decode(String.self, forKey: .html))
    }
}



class Author: Decodable {
    let id: Int
    let login: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
        case url = "url"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = (try values.decode(Int.self, forKey: .id))
        self.login = (try values.decode(String.self, forKey: .login))
        self.url = (try values.decode(String.self, forKey: .url))
    }
}





