//
//  InvoiceTableViewController.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 19/09/21.
//

import UIKit

class InvoiceTableViewController: UITableViewController {

    var parentView: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AuthenticationAPIManager.shared.credentials.invoices?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceItemCell", for: indexPath) as! InvoiceItemCell
        
        let item = AuthenticationAPIManager.shared.credentials.invoices?[indexPath.row]
        
        cell.month.text = item?.dueDate
        cell.total_value.text = "R$ \(item?.value.toPrice() ?? "0.00")"
        
        if item?.valueToBePaid() == "0" {
            cell.total_value.textColor = UIColor.systemGreen
        }
        else {
            cell.total_value.textColor = UIColor.systemOrange
        }
        
        return cell
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
//        self.navigationController?.popToRootViewController(animated: true)
    }
}
