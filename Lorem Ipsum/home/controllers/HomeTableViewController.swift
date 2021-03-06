//
//  HomeTableViewController.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 11/09/21.
//

import UIKit

class HomeTableViewController: UITableViewController, PasswordDelegate {
    
    @IBOutlet var current: UILabel!
    @IBOutlet var accumulated: UILabel!
    
    @IBOutlet var invoice: UILabel!
    @IBOutlet var invoiceDueDate: UILabel!
    @IBOutlet var payButton: UIButton!
    
    var hideInfo = true
    
    private var pendingInvoice: InvoiceItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearAllPreviousNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showHideFields()
    }
    
    private func showHideFields(){
        print("showHideFields")
        updateInvoiceLabel()
        accumulated.text = AuthenticationAPIManager.shared.credentials.account?.monthAccumulated?.toPrice()
        
        if let dueDate = pendingInvoice?.dueDate{
            invoiceDueDate.text = dueDate
        }
        
        if hideInfo{
            current.text = "******"
            invoice.text = "******"
        }
        else{
            current.text = AuthenticationAPIManager.shared.credentials.account?.balance?.toPrice()
            
            if let pendingInvoice = pendingInvoice{
                invoice.text = pendingInvoice.valueToBePaid().toPrice()
            }
        }
        disableButton()
    }
    
    @IBAction func onEyeCurrentTouch(_ sender: Any) {
        hideInfo = !hideInfo
        showHideFields()
    }
    @IBAction func onEyeInvoiceTouch(_ sender: Any) {
        hideInfo = !hideInfo
        showHideFields()
    }
    @IBAction func onQRCodePixTouch(_ sender: Any) {
        let storyboard = UIStoryboard(name: "PixReceiver", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PixQRCodeViewController") as! PixQRCodeViewController
        vc.qrCodeString = generatePixCode()
        vc.qrValue = "R$ 0,00"
        vc.parentVC = self
        present(vc, animated: true)
    }
    @IBAction func payInvoice(_ sender: Any) {
        PasswordCheckViewController.showModal(parentVC: self, sameWindows: true, tag: "CHECKPASSWORD")
    }
    @IBAction func seeInvoice(_ sender: Any) {
        navigateToInvoiceListWindows()
    }
    @IBAction func referralToAFriend(_ sender: Any) {
        let textToShare = "Hey there! I'm using Lorem Bank and it's Awesome!\n\nDownload Lorem Bank to get pre approvated cretid limit of $1000 right now!\nVisit www.lorenbank.com.br/app"
        shareText(text: textToShare)
    }
    
    private func clearAllPreviousNavigation(){
        guard let navigationController = self.navigationController else { return }
        var navigationArray = navigationController.viewControllers
        let temp = navigationArray.last
        navigationArray.removeAll()
        navigationArray.append(temp!)
        self.navigationController?.viewControllers = navigationArray
    }
    
    private func generatePixCode() -> String{
        return "00020101021126540014br.gov.bcb.pix0111\(AuthenticationAPIManager.shared.credentials.cpf ?? "")021752040000530398654060005802BR5924\(AuthenticationAPIManager.shared.credentials.name ?? "")6009SAO PAULO622905251FFKBEBPHMKGJBTMCA82KZCKP63046CD8"
    }
    
    func onPasswordCheck(check: Bool, tag: String) {
        if check {
            sendOrderToPayInvoice()
        }
        else{
            toast(message: "Voc?? n??o tem permiss??o para fazer essa opera????o")
        }
    }
    
    private func sendOrderToPayInvoice(){
        guard let invoice = pendingInvoice,
              let cpfTo = AuthenticationAPIManager.shared.credentials.cpf else{
            updateInvoiceLabel()
            return
        }
        
        InvoiceAPIManager.shared.payInvocie(cpfTo, invoice){
            user, errorMsg in
            
            if let user = user{
                AuthenticationAPIManager.shared.credentials = user
                self.onInvoicePaymentSuccessed()
                self.showMessage(msg: "Fatura paga com sucesso!")
            }
            else{
                guard let errorMsg = errorMsg else {
                    return
                }
                self.showMessage(msg: errorMsg)
            }
        }
    }
    
    private func updateInvoiceLabel(){
        pendingInvoice = AuthenticationAPIManager.shared.credentials.getLastPendingInvoice()
        
        if pendingInvoice == nil{
            invoice.text = "0.00"
            
            let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date())?.get(.day, .month, .year)
            if let month = nextMonth?.month {
                if let paymentDay = AuthenticationAPIManager.shared.credentials.creditcard?.paymentDay{
                    invoiceDueDate.text = "\(paymentDay)"+"\\"+"\(month)"
                }
            }
            
        }
    }
    
    private func disableButton(){
        payButton.isEnabled = pendingInvoice != nil
    }
    
    private func onInvoicePaymentSuccessed(){
        DispatchQueue.main.async {
            self.showHideFields()
        }
    }
    
    private func showMessage(msg:String){
        DispatchQueue.main.async {
            self.toast(message: msg)
        }
    }
    
    private func navigateToInvoiceListWindows(){
        let storyboard = UIStoryboard(name: "Invoice", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "InvoiceTableViewController") as! InvoiceTableViewController
        
        vc.parentView = self
//        navigationController?.show(vc, sender: self)
        navigationController?.present(vc, animated: true, completion: nil)
    }
}
