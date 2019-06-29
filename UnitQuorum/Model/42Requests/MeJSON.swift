//
//  MeJSON.swift
//  UnitQuorum
//
//  Created by ANASTASIA on 6/18/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation

class MeJSON:  Decodable {
    let id: Int?
    let login, firstName, lastName: String?
    let url: String?
    let displayname: String?
  //  let languagesUsers: [LanguagesUser]?
    
    enum CodingKeys: String, CodingKey {
        case id, login
        case firstName = "first_name"
        case lastName = "last_name"
        case url, displayname
        //case languagesUsers = "languages_users"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = (try? values.decode(Int.self, forKey: .id))
        self.login = (try? values.decode(String.self, forKey: .login))
        self.firstName = (try? values.decode(String.self, forKey: .firstName))
        self.lastName = (try? values.decode(String.self, forKey: .lastName))
        self.url = (try? values.decode(String.self, forKey: .url))
        self.displayname = (try? values.decode(String.self, forKey: .displayname))
       // self.languagesUsers = (try? values.decode([LanguagesUser].self, forKey: .languagesUsers))
    }
}
