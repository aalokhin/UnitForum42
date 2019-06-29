//
//  CreateNewTopicViewController.swift
//  UnitQuorum
//
//  Created by ANASTASIA on 6/17/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation
import UIKit

class CreateNewTopicViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var topicText: UITextView!
    let publishTopicURL = "https://api.intra.42.fr/v2/topics"
    
    
    @IBOutlet weak var topicName: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("Hello from Create Topic View!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    
        
        
    }
    
  
    
    
    @IBAction func SaveTapped(_ sender: UIBarButtonItem) {
        
        if (topicText.text != nil && topicName.text != "")
        {
            let topicRaw = TopicToSend(name : topicName.text!, content : topicText.text!, kind : "normal", author : Client.sharedInstance.myId)
            let topic = TopicPostJSON(topic : topicRaw)
            sendTopicToServer(topic : topic)
            
//            print(topic.name)
//            print(topic.messages_attributes)
//            print(topic.messages_attributes[0].content)
//            print(topic.messages_attributes[0].author_id)
            print("saved")
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            let alertController = UIAlertController(title: "hey there", message: "Please enter the name and the text of the topic", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "We'll do", style: .default, handler: nil)
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        

    }
    
    func sendTopicToServer(topic : TopicPostJSON){
        
         let jsonEncoder = JSONEncoder()
        
        do
        {
            

            var request = URLRequest(url : URL(string : publishTopicURL)!)

            request.httpMethod = "POST"
            let jsonData = try jsonEncoder.encode(topic)
            request.setValue("application/json", forHTTPHeaderField : "Content-Type")
            request.setValue("Bearer \(Client.sharedInstance.token)", forHTTPHeaderField: "Authorization")
            request.httpBody = jsonData

           
           // print(jsonData)
            //print("JSON data: ")
            //print("request: \(request)")
        

//
//            let json1 = try JSONSerialization.jsonObject(with: jsonData, options: [])
//            print(json1)

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

                      let json = try JSONSerialization.jsonObject(with: data, options: [])
                    // print(json)



                }
                catch {
                    print(error)
                    print("error in posting topic")
                }
                //                DispatchQueue.main.async {
                //                    self.parseTopic(d : data)
                //
                //                }
            }
            session.resume()

 //********************************************************************************

       }
        catch{
            print("Error encoding")
        }
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print("in here FIrst responder works")
//        self.topicText.becomeFirstResponder()
//        return true
//    }
    

    
    @IBAction func CancelButtonTapped(_ sender: UIBarButtonItem) {
        print("cancel2 tapped")
        self.navigationController?.popViewController(animated: true)
    }
    
}



