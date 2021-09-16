//
//  PixReceiverViewController.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 14/09/21.
//

import UIKit

class PixReceiverViewController: UIViewController, PopUpDelegate {

    @IBOutlet var insertValueButton: UIButton!
    @IBOutlet var keyLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var valueInserted: UILabel!
    @IBOutlet var container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showHideFields()
    }

    @IBAction func insertValue(_ sender: Any) {
        openPriceDialog()
        
    }
    
    @IBAction func editValue(_ sender: Any) {
        openPriceDialog()
    }
    
    @IBAction func edit_key(_ sender: Any) {
        openKeyDialog()
    }
    
    @IBAction func editDescription(_ sender: Any) {
        openDescriptionDialog()
    }
    
    @IBAction func createQRCode(_ sender: Any) {
        let storyboard = UIStoryboard(name: "PixReceiver", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PixQRCodeViewController") as! PixQRCodeViewController
        vc.qrCodeString = generatePixCode()
        vc.qrValue = valueInserted.text ?? "R$ 0,00"
        vc.parentVC = self
        present(vc, animated: true)
    }
    
    func onConfirmedText(typedText: String, tag: String) {
        if tag == "VALUE"{
            if Int(typedText) != 0{
                container.isHidden = false
            }
            else{
                container.isHidden = true
            }
            insertValueButton.isHidden = !container.isHidden
            valueInserted.text = "R$ \(typedText.toPrice())"
        }
        else if tag == "DESCRIPTION"{
            descriptionLabel.text = typedText
        }
        else if tag == "KEY"{
            keyLabel.text = typedText
        }
    }
    
    private func showHideFields(){
        container.isHidden = true
        keyLabel.text = AuthenticationAPIManager.shared.credentials.cpf
    }
    
    private func openPriceDialog(){
        InputViewController.showInputModal(parentVC: self, payload: InputDetailModel(title: "Qual é o valor a ser pago?", sutitlePlaceholder: "R$ 0,00", minLength: 1, maxLength: 5, allowedCharacters: Presets.NUMERIC_CHARS), sameWindows: true, tag: "VALUE")
    }
    
    private func openDescriptionDialog(){
        InputViewController.showInputModal(parentVC: self, payload: InputDetailModel(title: "Descrição (opcional)", sutitlePlaceholder: "61 Caracteres", minLength: 1, maxLength: 61, allowedCharacters: Presets.ANY), sameWindows: true, tag: "DESCRIPTION")
    }
    
    private func openKeyDialog(){
        InputViewController.showInputModal(parentVC: self, payload: InputDetailModel(title: "Chave", sutitlePlaceholder: "CPF/CNPJ/Email...", minLength: 8, maxLength: 35, allowedCharacters: Presets.ANY), sameWindows: true, tag: "KEY")
    }
    @IBAction func onBackButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func generatePixCode() -> String{
        return "00020101021126540014br.gov.bcb.pix0111\(keyLabel.text ?? "")0217\(descriptionLabel.text ?? "")5204000053039865406\(valueInserted.text ?? "")5802BR5924\(AuthenticationAPIManager.shared.credentials.name ?? "")6009SAO PAULO622905251FFKBEBPHMKGJBTMCA82KZCKP63046CD8"
    }
}
