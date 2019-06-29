//
//  TopicCell.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 6/1/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation

import UIKit

class TopicCell : UITableViewCell {
    

    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var topicLbl: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier) // the common code is executed in this super call
            self.backgroundColor = .black
            print("***************************************CELLLLLLLLLLLLLLLL 222 ***************************************")
        
        // code unique to CellOne goes here
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .gray
    }
    
    func designSelf(){
        authorLbl.sizeToFit()
        dateLbl.sizeToFit()
        topicLbl.sizeToFit()
        dateLbl.numberOfLines = 1
        authorLbl.numberOfLines = 1
        topicLbl.numberOfLines = 0
        dateLbl.adjustsFontSizeToFitWidth = true
        self.backgroundColor = UIColor(white: 1, alpha: 0.6)
    }
}



//
//class FullTopicDisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource   {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        print("mssgs count >>>>>>>>>>>>>>>>>>>>.. \(messages.count)")
//        //print("mssgs count >>>>>>>>>>>>>>>>>>>>.. \(messages[0].replies?.count)" )
//        return 100
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath)
//
//        let message = messages[indexPath.row]
//        cell.textLabel?.text = "\(message.content) created on \(message.created_at)\n"
//        cell.textLabel?.sizeToFit()
//        //
//        cell.textLabel?.numberOfLines = 0
//        return cell
//
//    }
//
//
//    // var topic : TopicJSON
//    var topicID : Int = -1
//
//    var messages : [MessageJSON] = []
//
//    @IBOutlet weak var tableView: UITableView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("hello from dispaly topic")
//        print("topic ID \(topicID)")
//        getMessages()
//    }
//
//
//    //  GET /v2/messages/graph(/on/:field(/by/:interval))
//    //  GET /v2/topics/:topic_id/messages/:message_id/messages
//    // GET /v2/topics/:topic_id/messages}
//
//    //https://api.intra.42.fr/apidoc/2.0/topics/show.html
//
//
//    func getMessages()
//    {
//        let urlPath: String = "https://api.intra.42.fr/v2/topics/\(topicID)/messages"
//        let url = URL(string: urlPath)
//        let request : NSMutableURLRequest = NSMutableURLRequest(url: url!)
//        request.httpMethod = "GET"
//        request.setValue("Bearer " + Client.sharedInstance.token, forHTTPHeaderField: "Authorization")
//
//        let session = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
//            if let response = response {
//                print("response received")
//
//                // print(response)
//            }
//            guard let data = data else {
//                //  print("no data received")
//                return
//            }
//            print(data)
//            do {
//
//                let json :  [NSDictionary] = (try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary])!
//                print(json)
//                //
//                self.parseMessages(d : data)
//                //                    DispatchQueue.main.async {
//                //
//                //                        self.tableView.reloadData()
//                //                    }
//
//            }
//            catch {
//                print(error)
//                print("error in get_messages")
//            }
//        }
//        session.resume()
//    }
//
//    func parseMessages(d : Data!)
//    {
//        let decoder = JSONDecoder()
//
//        let m = try! decoder.decode([MessageJSON].self, from: d)
//        for msg in m
//        {
//            messages.append(msg)
//            print("msg ID : \(msg.id)")
//            print("Created at: \(msg.created_at)")
//            print("Updated at: \(msg.updated_at)")
//            print("msg cont: \(msg.content)")
//            print("Author name: \(msg.author.login)")
//        }
//        //
//        //        DispatchQueue.main.async {
//        //            self.tableView.reloadData()
//        //        }
//    }
//
//
//}
//
