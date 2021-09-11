//
//  CredicardViewController.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 07/09/21.
//

import UIKit

class CreditcardViewController: UIViewController {

    @IBOutlet var name: UILabel!
    @IBOutlet var cardNumber: UILabel!
    @IBOutlet var validThru: UILabel!
    @IBOutlet var balance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = "Daniel Q Pontes"
        cardNumber.text = "**** **** **** 5037"
        validThru.text = "23/28"
        balance.text = "$1500"
    }
    
}
