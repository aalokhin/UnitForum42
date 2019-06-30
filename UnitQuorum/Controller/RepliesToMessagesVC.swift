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
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        print("Hi from this RepliesToMessagesVC!")
        print(messageText)
//        for one in replies{
//            print(one.content)
//        }
    }
    
}

extension RepliesToMessagesVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return replies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReplyCell", for: indexPath)
        cell.textLabel?.text = replies[indexPath.row].content
        cell.textLabel?.sizeToFit()
        //cell.backgroundColor = .blue
        return cell
    }
    
}
