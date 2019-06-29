//
//  Token.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 6/1/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation

//JSON  IMplementation of oken data received
class TokenJSON : Decodable{
    
    let access_token : String
    let created_at : Date
    let expires_in :  Int
  //  let token_type : String

    
    enum CodingKeys: String, CodingKey {
        case access_token = "access_token"
        case created_at = "created_at"
        case expires_in = "expires_in"
       // case token_type = "token_type"
    }
    

//    scope = public;

}
