//
//  PixLimiteConfirmedViewController.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 14/09/21.
//

import UIKit

class PixLimitConfirmedViewController: UIViewController {
    
    var parentVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onConfirmClick(_ sender: Any) {
        self.parentVC?.navigationController?.popToRootViewController(animated: false)
        dismiss(animated: true) {
            
        }
    }
    
}
