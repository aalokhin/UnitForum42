//
//  ListTopicCell.swift
//  UnitQuorum
//
//  Created by Anastasiia ALOKHINA on 6/29/19.
//  Copyright © 2019 Anastasiia ALOKHINA. All rights reserved.
//

import Foundation
import UIKit

class ListTopicCell : UITableViewCell{
    

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
//    
}
