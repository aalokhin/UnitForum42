//
//  Client.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 5/22/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation

//Singleton instance

final class Client {
    
    static let apiUid = "a3e38e966c9817266d40eabd4dcdf82bdca4bed880f7da7c490a17f8658f41fd"
    static let apiSecret = "56fecc48f9aeeb77e9cfefad10d4ea3f0c08c005909a1327630984c8dbcc1d7b"
    static let scope = "public forum".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
   // static var state: String {return randomString(length: 64)}
    static let baseUrl = "https://api.intra.42.fr/"
    static let redirectURI = "myapp00://forum".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
   static let callbackUrlScheme =  "myapp00://forum"
    static let authorizationURL = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=\(apiUid)&redirect_uri=\(redirectURI)&scope=\(scope)&response_type=code")

   
    static let DateFormat = "dd.MM.yyyy HH:mm:ss"
    
    var isSignedIn : Bool
    var myId = 0
    var myLogin = ""
    var token : String
    
    
    //============================================================SINGLETON============================================================
    static let sharedInstance = Client()
    
    private init(){
        print("Singleton client has been initialized")
        token = ""
        isSignedIn = false
    }
    //============================================================SINGLETON============================================================

    
    func setToken(t : String)
    {
        self.token = t
    }
    
    
    
    

    //plagiat
    static func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
}

extension Date{
    
    func toString() -> String {
        let format = "dd/MM/yyyy HH:mm"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension String {
    func toDate()-> Date? {
        let format : String = "E MMM dd HH:mm:ss Z yyyy"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}



