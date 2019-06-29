//
//  ListTopicsVC.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 6/29/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation
import UIKit

class ListTopicsVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var topics : [TopicJSON] = []
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       self.navBar.isHidden = false
    self.navigationController?.setNavigationBarHidden(false, animated: false)

        //        print(Client.sharedInstance.myLogin)
        //        print(Client.sharedInstance.myId)
        //        print(Client.sharedInstance.token)
        self.getTopics()
        print("hello from topics list Intra")
    }
    
    func getTopics() {
        let urlPath: String = "https://api.intra.42.fr/v2/topics"
        let url = URL(string: urlPath)
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer " + Client.sharedInstance.token, forHTTPHeaderField: "Authorization")
        let session = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if (response == nil ||  data == nil){
                print("response not received")
                //self.callErrorWithCustomMessage(message: "No response for get token request")
                return
            }
            self.parseTopic(d : data)
        }
        session.resume()
    }
    
    
    func parseTopic(d : Data!)
    {
        let decoder = JSONDecoder()
        
        // print("*******************************************  DEBUG  *********************************************************")
        //  let data = "any string".data(using: .utf8)!
        // print("*******************************************  DEBUG  *********************************************************")
        
        guard let t = try? decoder.decode([TopicJSON].self, from: d) else {
            //self.callErrrorAndGetBackToLoginController(message: "Topic failed to be decoded!")
            return
        }
        for topic in t
        {
            topics.append(topic)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func LogOut(_ sender: UIBarButtonItem) {
        print("Log Out Button Tapped")
        Client.sharedInstance.token = ""
        Client.sharedInstance.isSignedIn = false
        Client.sharedInstance.myId = 0
        Client.sharedInstance.myLogin = ""
        navigationController?.viewControllers.forEach { ($0 as? LoginViewController)?.viewDidLoad()}
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func MyTopics(_ sender: UIBarButtonItem) {
        print("Opened my Topics")
        let vc = openMyTopicsViewController() as! MyTopicsViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func composeTopic(_ sender: UIBarButtonItem) {
        print("create button tapped")
        let vc = openCreateTopicViewController() as!  CreateNewTopicViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*
    @IBAction func CreateButtontapped(_ sender: UIBarButtonItem) {
        print("create button tapped")
        let vc = openCreateTopicViewController() as!  CreateNewTopicViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func MyTopicsButtonTapped(_ sender: UIBarButtonItem) {
        
        print("Opened my Topics")
        let vc = openMyTopicsViewController() as! MyTopicsViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func LogOutButtonTapped(_ sender: UIBarButtonItem) {
        print("Log Out Button Tapped")
        Client.sharedInstance.token = ""
        Client.sharedInstance.isSignedIn = false
        Client.sharedInstance.myId = 0
        Client.sharedInstance.myLogin = ""
        navigationController?.viewControllers.forEach { ($0 as? LoginViewController)?.viewDidLoad()}
        navigationController?.popViewController(animated: true)
    }
    
  */
    
}


//extension ListTopicsVC {
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.backgroundColor = .red
//        return cell
//    }
//
//
//
//
//}




extension ListTopicsVC {
    
    func callErrorWithCustomMessage(message : String) {
        
        let alert = UIAlertController(
            title : "Error",
            message : message,
            preferredStyle : UIAlertControllerStyle.alert
        );
        alert.addAction(UIAlertAction(title: "allright, thank you", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func callError(error: NSError) {
        
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: UIAlertControllerStyle.alert
        );
        alert.addAction(UIAlertAction(title: "allright, thank you", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func callErrrorAndGetBackToLoginController(message : String){
        Client.sharedInstance.token = ""
        Client.sharedInstance.isSignedIn = false
        Client.sharedInstance.myId = 0
        Client.sharedInstance.myLogin = ""
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            self.navigationController?.viewControllers.forEach { ($0 as? LoginViewController)?.viewDidLoad()}
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(topics.count)
        return topics.count
        
    }
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)")
        let vc = getViewController() as!  FullTopicDisplayViewController
        vc.topicID = self.topics[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openMyTopicsViewController() -> UIViewController
    {
        let storyboard = UIStoryboard.init(name: "MyTopics", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier : "MyTopicsViewController") as! MyTopicsViewController
        return vc
    }
    func getViewController() -> UIViewController
    {
        let storyboard = UIStoryboard.init(name: "FullTopicStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier : "FullTopicDisplayViewController") as! FullTopicDisplayViewController
        return vc
    }
    
    func openCreateTopicViewController() -> UIViewController
    {
        let storyboard = UIStoryboard.init(name: "CreateNewTopic", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier : "CreateNewTopicViewController") as! CreateNewTopicViewController
        return vc
    }
    
}

