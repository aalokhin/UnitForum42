//
//  MyTopicsViewController.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 6/23/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation
import UIKit

// GET /v2/users/:user_id/topics
//  GET /v2/me/topics

class MyTopicsViewController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var myTopics : [TopicJSON] = []
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        print("Hi from this MyTopicsViewController!")
        getMyTopics()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getMyTopics()
    {
        let urlPath: String = "https://api.intra.42.fr/v2/me/topics"
        let url = URL(string: urlPath)
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer " + Client.sharedInstance.token, forHTTPHeaderField: "Authorization")
        let session = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let _ = response, let data = data else {
                print("error receiving data/response received")
                return
            }
            do {
                let json =  try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                self.parseMyTopic(d : data)
            }
            catch {
                
            }
            
        }
        session.resume()
    }
    
    func parseMyTopic(d : Data!)
    {
        let decoder = JSONDecoder()
        
        guard let t = try? decoder.decode([TopicJSON].self, from: d) else {
            callErrorWithCustomMessage(message: "Error decoding my topic")
            return
        }
        for topic in t
        {
            self.myTopics.append(topic)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension MyTopicsViewController{
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







extension MyTopicsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        return myTopics.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let topic = myTopics[indexPath.row]
        cell.textLabel?.text = "\(topic.author.login): \(topic.name) created on \(topic.created_at)\n"
        cell.textLabel?.sizeToFit()
        cell.textLabel?.numberOfLines = 0
        return cell

        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            //print("we are going to delete a note right away at \(indexPath.row) ")
            let id = myTopics[indexPath.row].id
            let urlPath: String = "https://api.intra.42.fr/v2/topics/\(id)"
            let url = URL(string: urlPath)
            let request: NSMutableURLRequest = NSMutableURLRequest(url: url!)
            request.httpMethod = "DELETE"
            request.setValue("Bearer " + Client.sharedInstance.token, forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                (data, response, error) in
            guard let _ = data, let _ = response else {
                self.callErrorWithCustomMessage(message: "Response error try again")
                return
            }
            DispatchQueue.main.async {
                    self.myTopics.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    tableView.reloadData()
                }
            }
            task.resume() 
        }
    }
    

    
    
}
