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
            if let response = response {
                print("response received")
                //print(response)
            }
            guard let data = data else {
                //  print("no data received")
                return
            }
            //print(data)
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
        
        let t = try! decoder.decode([TopicJSON].self, from: d)
        for topic in t
        {
            self.myTopics.append(topic)

        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}








extension MyTopicsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        return myTopics.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "lalala"
//        cell.textLabel?.numberOfLines = 0
        
        let topic = myTopics[indexPath.row]
        cell.textLabel?.text = "\(topic.author.login): \(topic.name) created on \(topic.created_at)\n"
        cell.textLabel?.sizeToFit()
        cell.textLabel?.numberOfLines = 0
        return cell

        
    }
    
    //deletting a note
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            print("we are going to delete a note right away at \(indexPath.row) ")
            //TODO: Fix out pf range deletion

            
           // deleteTopic(id : myTopics[indexPath.row].id)
           // myTopics.remove(at: indexPath.row)
            
            // DELETE /v2/topics/:id
            
            
            //self.tableView.reloadData()
            let id = myTopics[indexPath.row].id
            
            let urlPath: String = "https://api.intra.42.fr/v2/topics/\(id)"
            let url = URL(string: urlPath)
            let request: NSMutableURLRequest = NSMutableURLRequest(url: url!)
            request.httpMethod = "DELETE"
            request.setValue("Bearer " + Client.sharedInstance.token, forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                (data, response, error) in
                do {
                    
                    // what happens if error is not nil?
                    // That means something went wrong.
                    
                    // Make sure there really is some data
                    if let data = data {
                        let response = try JSONSerialization.jsonObject(with: data, options: [])
                        print(response)
                        DispatchQueue.main.async {
                            self.myTopics.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .automatic)
                            tableView.reloadData()
                        }
                        //completion(response)
                    }
                    else {
                        // Data is nil.
                    }
                } catch let error as NSError {
                    print("json error: \(error.localizedDescription)")
                }
            }
            task.resume()
            
            
            
            
        }
    }
    

    
    
}
