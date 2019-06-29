//
//  ErrorJSON.swift
//  UnitQuorum
//
//  Created by ANASTASIA on 5/24/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation

class ErrorJSON: Error, Decodable
{
    var error: String
    var error_description: String
    
    enum CodingKeys: String, CodingKey {
        case error = "error"
        case error_description = "error_description"
    }
}
