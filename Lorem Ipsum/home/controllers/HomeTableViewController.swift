//
//  HomeTableViewController.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 11/09/21.
//

import UIKit

class HomeTableViewController: UITableViewController {

    @IBOutlet var current: UILabel!
    @IBOutlet var accumulated: UILabel!
    
    @IBOutlet var invoice: UILabel!
    @IBOutlet var invoiceDueDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        current.text = "1250,00"
        accumulated.text = "9,89"
        
        invoice.text = "100,00"
        invoiceDueDate.text = "01/05"
    }
    @IBAction func onEyeCurrentTouch(_ sender: Any) {
        current.text = "******"
    }
    @IBAction func onEyeInvoiceTouch(_ sender: Any) {
        invoice.text = "******"
    }
    @IBAction func onTransferPixTouch(_ sender: Any) {
    }
    @IBAction func onReceivedPixTouch(_ sender: Any) {
    }
    @IBAction func onLimitePixTouch(_ sender: Any) {
    }
    @IBAction func onQRCodePixTouch(_ sender: Any) {
    }
    @IBAction func payInvoice(_ sender: Any) {
    }
    @IBAction func seeInvoice(_ sender: Any) {
    }
    @IBAction func referralToAFriend(_ sender: Any) {
        //openWhatsApp()
        openEmail()
    }
    
    private func openWhatsApp(){
        var whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=9530670491&text=Lorem Bank is awesome! Download it now.")
        if UIApplication.shared.canOpenURL(whatsappURL!) {
            UIApplication.shared.openURL(whatsappURL!)
        }
    }
    
    private func openEmail(){
        /** It will not work on emulator, only in real device */
        let subject = "Lorem Bank Awesome!"
        let body = "Download Lorem Bank now and get pre approvated cretid limit right now!"
        let coded = "mailto:blah@blah.com?subject=\(subject)&body=\(body)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        if let emailURL: NSURL = NSURL(string: coded!) {
            if UIApplication.shared.canOpenURL(emailURL as URL) {
                UIApplication.shared.openURL(emailURL as URL)
            }
        }
    }
}
