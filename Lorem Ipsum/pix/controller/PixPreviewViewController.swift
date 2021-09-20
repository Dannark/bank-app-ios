//
//  PixPreviewViewController.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 13/09/21.
//

import UIKit

class PixPreviewViewController: UIViewController, PopUpDelegate, PasswordDelegate {
    
    @IBOutlet var nome: UILabel!
    @IBOutlet var banco: UILabel!
    @IBOutlet var conta: UILabel!
    @IBOutlet var cpf: UILabel!
    @IBOutlet var pixValue: UILabel!
    
    @IBOutlet var confirmButton: UIButton!
    
    @IBOutlet var userName: UILabel!
    @IBOutlet var bankName: UILabel!
    @IBOutlet var agencyName: UILabel!
    @IBOutlet var cpfName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillDialog()
        validateConfirmButton(isActive: false)
    }
    
    private func fillDialog(){
        userName.text = PixAPIManager.shared.credentials.name
        bankName.text = PixAPIManager.shared.credentials.account?.bank
        agencyName.text = "Agência: \(PixAPIManager.shared.credentials.account?.agency ?? "-") Conta: \(PixAPIManager.shared.credentials.account?.number ?? "-")"
        cpfName.text = PixAPIManager.shared.credentials.cpf?.maskWithAsteriscts(amountIndex: 6)
    }
    
    private func openInputValueDialog(){
        validateConfirmButton(isActive: false)
        InputViewController.showInputModal(parentVC: self, payload: InputDetailModel(title: "Quanto deseja enviar?", sutitlePlaceholder: "R$ 0.00", minLength: 1, maxLength: 10, allowedCharacters: Presets.FLOAT_CHARS), sameWindows: true, tag: "PIXVALUE")
    }
    
    func onConfirmedText(typedText: String, tag: String) {
        pixValue.text = typedText.toPrice()
        
        if let currentPixValue = Float(typedText),
           let pixLimit = Float(AuthenticationAPIManager.shared.credentials.limitPix ?? "0.0"),
           let balance = Float(AuthenticationAPIManager.shared.credentials.account?.balance ?? "0.0"){
            
            var validate = true
            if currentPixValue > balance{
                self.toast(message: "Você não tem saldo em conta suficiente para enviar esse valor")
                validate = false
            }
            else if currentPixValue > pixLimit{
                self.toast(message: "Esse valor ultrapassa o limite de pix diario")
                validate = false
            }
            else if currentPixValue <= 0.0{
                validate = false
            }
            validateConfirmButton(isActive: validate)
        }
        
    }
    @IBAction func editar(_ sender: Any) {
        openInputValueDialog()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        openInputValueDialog()
    }
    
    private func validateConfirmButton(isActive: Bool){
        confirmButton.isEnabled = isActive
        if confirmButton.isEnabled{
            confirmButton.backgroundColor = UIColor.systemPink
        }
        else{
            confirmButton.backgroundColor = UIColor.systemGray5
        }
        
    }
    @IBAction func onConfirmPressed(_ sender: Any) {
        PasswordCheckViewController.showModal(parentVC: self, sameWindows: true, tag: "CHECKPASSWORD")
    }
    
    func onPasswordCheck(check: Bool, tag: String) {
        if check {
            sendPix()
        }
    }
    
    private func sendPix(){
        PixAPIManager.shared.sendPix(
            PixAPIManager.shared.credentials.cpf!, pixValue.text!, AuthenticationAPIManager.shared.credentials.cpf!){
            pixResult, errorMsg in
            
            if let pixResult = pixResult{
                AuthenticationAPIManager.shared.credentials = pixResult //Atualiza pix
                self.navigateToConfirmView()
            }
            else{
                guard let errorMsg = errorMsg else {
                    return
                }
                self.showError(error: errorMsg)
            }
            
        }
    }
    
    private func navigateToConfirmView(){
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Pix", bundle: nil)
            let pvc = storyboard.instantiateViewController(withIdentifier: "PixConfirmedViewController") as! PixConfirmedViewController
            
            pvc.parentView = self
            self.present(pvc, animated: true)
        }
    }
    
    private func showError(error:String){
        DispatchQueue.main.async {
            self.toast(message: error)
        }
    }
}
