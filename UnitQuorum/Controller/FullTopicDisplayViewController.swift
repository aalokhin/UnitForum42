//
//  FullTopicDisplayViewController.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 6/15/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation
import UIKit
import WebKit



class FullTopicDisplayViewController: UIViewController  {
    
   // var topic : TopicJSON
    var topicID : Int = -1
    var messages : [MessageJSON] = []
    
    @IBOutlet weak var loginLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var topicTextLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello from dispaly topic")
        print("topic ID \(topicID)")
        //print(topic.author.login)
        //print(topic.name)
        getMessages()
        
        
    }
        
        
        //  GET /v2/messages/graph(/on/:field(/by/:interval))
      //  GET /v2/topics/:topic_id/messages/:message_id/messages
       // GET /v2/topics/:topic_id/messages    }
        
        //https://api.intra.42.fr/apidoc/2.0/topics/show.html
        
        
        func getMessages()
        {
            let urlPath: String = "https://api.intra.42.fr/v2/topics/\(topicID)/messages"
            let url = URL(string: urlPath)
            let request : NSMutableURLRequest = NSMutableURLRequest(url: url!)
            request.httpMethod = "GET"
            request.setValue("Bearer " + Client.sharedInstance.token, forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                if let response = response {
                    print("response received")
          
                   // print(response)
                }
                guard let data = data else {
                    //  print("no data received")
                    return
                }
                print(data)
                do {
                    
                      let json :  [NSDictionary] = (try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary])!
                    //print(json)
//
                    self.parseMessages(d : data)
                    
                    
                }
                catch {
                    print(error)
                    print("error in get_messages")
                }
                //                DispatchQueue.main.async {
                //                    self.parseTopic(d : data)
                //
                //                }
            }
            session.resume()
        }
    
    func parseMessages(d : Data!)
    {
        let decoder = JSONDecoder()
        
        let m = try! decoder.decode([MessageJSON].self, from: d)
        for msg in m
        {
            if(msg.is_root == true)
            {
                DispatchQueue.main.async {
                    self.loginLbl.text = msg.author.login
                    self.dateLbl.text = msg.created_at
                    self.topicTextLbl.text = msg.content
                    self.loginLbl.sizeToFit()
                    self.dateLbl.sizeToFit()
                    self.topicTextLbl.sizeToFit()
                }
            }
            
            messages.append(msg)
            print("is it a main topic?? \(msg.is_root)")
//            print("msg ID : \(msg.id)")
//            print("Created at: \(msg.created_at)")
//            print("Updated at: \(msg.updated_at)")
//            print("msg cont: \(msg.content)")
//            print("Author name: \(msg.author.login)")
        }
        print("total number of messages  in topic ===========> \(messages.count)")
        
        if (!messages.isEmpty){
        //loginLbl.text = messages[]
        }
        
//        DispatchQueue.main.async {
//            self.reloadData()
//        }
    }
    
   
   //  GET /v2/me
    
}

