//
//  PixConfirmedViewController.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 13/09/21.
//

import UIKit

class PixConfirmedViewController: UIViewController {
    
    var parentView: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: false) {
            self.parentView?.dismiss(animated: true, completion: {
                
            })
        }
    }
}
