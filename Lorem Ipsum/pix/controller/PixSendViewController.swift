//
//  PixSendViewController.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 12/09/21.
//

import UIKit

class PixSendViewController: UIViewController, PopUpDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func onConfirmedText(typedText: String, tag: String) {
        print("onConfirmed successfully \(typedText) on \(tag)")
        
        let storyboard = UIStoryboard(name: "Pix", bundle: nil)
        let pvc = storyboard.instantiateViewController(withIdentifier: "PixPreviewViewController") as! PixPreviewViewController
        present(pvc, animated: true)
        
    }
    
    
    @IBAction func goToCPFInput(sender: AnyObject) {
        InputViewController.showInputModal(parentVC: self, payload: InputDetailModel(title: "Digite o CPF/CNPJ", sutitlePlaceholder: "", minLength: 11, maxLength: 15, allowedCharacters: Presets.CPF_CHARS), sameWindows: true, tag: "CPF")
    }
    
    @IBAction func goToPhoneInput(_ sender: Any) {
        InputViewController.showInputModal(parentVC: self, payload: InputDetailModel(title: "Digite o telefone", sutitlePlaceholder: "", minLength: 11, maxLength: 11, allowedCharacters: Presets.NUMERIC_CHARS), sameWindows: true, tag: "PHONE")
    }
    @IBAction func goToEmail(_ sender: Any) {
        InputViewController.showInputModal(parentVC: self, payload: InputDetailModel(title: "Digite o Email", sutitlePlaceholder: "user@mail.com", minLength: 8, maxLength: 60, allowedCharacters: Presets.EMAIL_CHARS), sameWindows: true, tag: "EMAIL")
    }
    
    @IBAction func goToQRCode(_ sender: Any) {
        toast(message: "Pagamento QRCode ainda não está disponível.")
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
