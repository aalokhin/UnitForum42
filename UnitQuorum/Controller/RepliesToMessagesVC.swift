//
//  RepliesToMessagesVC.swift
//  UnitQuorum
//
//  Created by Artem Yatskiv on 6/29/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation
import UIKit

class RepliesToMessagesVC : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   var replies : [MessageJSON] = []
   var messageText = ""
       // : MessageJSON = MessageJSON()
    //@synthesize message = _message;
    
    //lazy var message : MessageJSON
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        print("Hi from this RepliesToMessagesVC!")
       print(messageText)
            for one in replies{
                print(one.content)
            }
      
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}

extension RepliesToMessagesVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReplyCell", for: indexPath)
        
        cell.backgroundColor = .blue
   
        return cell
    }
    
}
