//
//  CreateNewTopicViewController.swift
//  UnitQuorum
//
//  Created by ANASTASIA on 6/17/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//


/*
 
 navigationController?.viewControllers.forEach { ($0 as? LoginViewController)?.viewDidLoad()}
 navigationController?.popViewController(animated: true)
 */

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
            //print("saved")
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
        do
        {
            let jsonEncoder = JSONEncoder()
            var request = URLRequest(url : URL(string : publishTopicURL)!)
            request.httpMethod = "POST"
            let jsonData = try jsonEncoder.encode(topic)
            request.setValue("application/json", forHTTPHeaderField : "Content-Type")
            request.setValue("Bearer \(Client.sharedInstance.token)", forHTTPHeaderField: "Authorization")
            request.httpBody = jsonData
            let session = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                guard let _ = response, let _ = data else {
                    print("response not  received")
                    return
                }
            }
            session.resume()
       }
        catch {
            callErrorWithCustomMessage(message: "Error posting topic")
            print("Error encoding")
        }
    }

    
/*
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("in here FIrst responder works")
        self.topicText.becomeFirstResponder()
        return true
    }
 
 */
    

    
    @IBAction func CancelButtonTapped(_ sender: UIBarButtonItem) {
        print("cancel2 tapped")
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CreateNewTopicViewController{
    func callErrorWithCustomMessage(message : String) {
        
        let alert = UIAlertController(
            title : "Error",
            message : message,
            preferredStyle : UIAlertControllerStyle.alert
        );
        alert.addAction(UIAlertAction(title: "allright, thank you", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}



