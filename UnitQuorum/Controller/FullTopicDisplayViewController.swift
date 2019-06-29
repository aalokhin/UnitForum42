//
//  FullTopicDisplayViewController.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 6/15/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

/*
     GET /v2/messages/graph(/on/:field(/by/:interval))
     GET /v2/topics/:topic_id/messages/:message_id/messages
     GET /v2/topics/:topic_id/messages
     https://api.intra.42.fr/apidoc/2.0/topics/show.html
     GET /v2/me
*/


/*
 let json :  [NSDictionary] = (try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary])!
 print(json)
 */

import Foundation
import UIKit
import WebKit

class FullTopicDisplayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var responseTextField: UITextField!
    var topicID : Int = -1
    var messages : [MessageJSON] = []
    @IBOutlet weak var tableView: UITableView!
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

    func getMessages() {
        let urlPath: String = "https://api.intra.42.fr/v2/topics/\(topicID)/messages"
        let url = URL(string: urlPath)
        let request : NSMutableURLRequest = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer " + Client.sharedInstance.token, forHTTPHeaderField: "Authorization")
        let session = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let _ = response,  let data = data else {
                print("response received")
                return
            }
            self.parseMessages(d : data)
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
/*
            if (msg.replies?.count != 0)
            {
                print("Message has replies")
                if let replies = msg.replies{
                    for reply in replies{
                        print(reply.content)
                    }
                }
            }
*/
            print("is it a main topic?? \(msg.is_root)")
        }
        print("total number of messages  in topic ===========> \(messages.count)")
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }

    @IBAction func SendResponseClicked(_ sender: UIButton) {
       if (!responseTextField.text!.isEmpty){
            guard let text = responseTextField.text else {
                print("spmething went wrong in response sending ")
                return
            }
            responseTextField.text = nil
            let responseToMessage : String = text.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            let sendResponseURL = "https://api.intra.42.fr/v2/topics/\(topicID)/messages?message[author_id]=\(Client.sharedInstance.myId)&message[content]=\(responseToMessage)"
            print(sendResponseURL)
            let urlSend = URL(string : sendResponseURL)
            var request = URLRequest(url : urlSend!)
            //var request = URLRequest(url : URL(string : sendResponseURL)!)
            request.setValue("Bearer \(Client.sharedInstance.token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            print(request)
            let session = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                guard let _ = response, let _ = data else {
                    print("no response / data received")
                    return
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            session.resume()
        } else {
            print("can't send empty response")
        }
    }
    
    
    
}

extension FullTopicDisplayViewController {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessagesCell", for: indexPath) as? MessageCell
        cell?.backgroundColor = .red
        let message = messages[indexPath.row]
        cell?.contMsgLbl.text = message.content
        cell?.dateMsgLbl.text = message.created_at
        cell?.xolginMsgLbl.text = message.author.login
        cell?.replNbrLbl.text = "Replies: " + (message.replies?.count.toString())!
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "RepliesToMessages", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier : "RepliesToMessagesVC") as! RepliesToMessagesVC
        vc.replies =  messages[indexPath.row].replies!
        vc.messageText = messages[indexPath.row].content
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
}



extension FullTopicDisplayViewController : UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        /*
         if let input = textField.text{
            setToken(searchStr : input)
        }
        */
        print("here textFieldShouldReturn")
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 200
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}

extension Int{
    
    func toString() -> String
    {
        let myString = String(self)
        return myString
    }
}


/*

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListTopicCell
    let topic = topics[indexPath.row]
    cell.authorLbl.text = topic.author.login
    cell.dateLbl.text = topic.created_at.toDate()?.toString()
    cell.topicLbl.text = topic.name
    cell.designSelf()
    //cell.activityIndicator.startAnimating()
    return cell
}
*/
