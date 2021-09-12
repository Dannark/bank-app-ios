//
//  PixSendViewController.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 12/09/21.
//

import UIKit

class PixSendViewController: UIViewController, PopUpDelegate  {
    
    final var CPF_CHARS = "0123456789.-/"
    final var NUMERIC_CHARS = "0123456789"
    final var EMAIL_CHARS = "qwertyuiopasdfghjklçzxcvbnm_.0123456789@"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func onConfirmedText(typedText: String, tag: String) {
        print("onConfirmed successfully \(typedText) on \(tag)")
    }
    
    
    @IBAction func goToCPFInput(sender: AnyObject) {
        InputViewController.showInputModal(parentVC: self, payload: InputDetailModel(title: "Digite o CPF/CNPJ", sutitlePlaceholder: "", minLength: 11, maxLength: 15, allowedCharacters: CPF_CHARS), sameWindows: true, tag: "CPF")
    }
    
    @IBAction func goToPhoneInput(_ sender: Any) {
        InputViewController.showInputModal(parentVC: self, payload: InputDetailModel(title: "Digite o telefone", sutitlePlaceholder: "", minLength: 11, maxLength: 11, allowedCharacters: NUMERIC_CHARS), sameWindows: true, tag: "PHONE")
    }
    @IBAction func goToEmail(_ sender: Any) {
        InputViewController.showInputModal(parentVC: self, payload: InputDetailModel(title: "Digite o Email", sutitlePlaceholder: "user@mail.com", minLength: 8, maxLength: 60, allowedCharacters: EMAIL_CHARS), sameWindows: true, tag: "EMAIL")
    }
    
    @IBAction func goToQRCode(_ sender: Any) {
        toast(message: "Pagamento QRCode ainda não está disponível.")
    }
}

