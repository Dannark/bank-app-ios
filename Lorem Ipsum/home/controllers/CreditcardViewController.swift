//
//  CredicardViewController.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 07/09/21.
//

import UIKit

class CreditcardViewController: UIViewController {

    @IBOutlet var clientName: UILabel!
    @IBOutlet var cardNumber: UILabel!
    @IBOutlet var validThru: UILabel!
    @IBOutlet var balance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeFields()
    }
    
    private func initializeFields(){
        clientName.text = AuthenticationAPIManager.shared.credentials.creditcard?.clientName
        cardNumber.text = AuthenticationAPIManager.shared.credentials.creditcard?.cardNumber.maskWithAsteriscts(amountIndex: 14)
        validThru.text = AuthenticationAPIManager.shared.credentials.creditcard?.validDate
        balance.text = "R$ \(AuthenticationAPIManager.shared.credentials.creditcard?.balanceLimit.toPrice(removeDecimal: true) ?? "-")"
    }
    
}
