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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func openInputValueDialog(){
        InputViewController.showInputModal(parentVC: self, payload: InputDetailModel(title: "Quanto deseja enviar?", sutitlePlaceholder: "R$ 0.00", minLength: 1, maxLength: 10, allowedCharacters: Presets.NUMERIC_CHARS), sameWindows: true, tag: "PIXVALUE")
    }
    
    func onConfirmedText(typedText: String, tag: String) {
        pixValue.text = typedText.toPrice()
        validateConfirmButton(isActive: (pixValue.text != "0.00"))
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
        print("password is \(check)")
        if check {
            navigateToConfirmView()
        }
    }
    
    private func navigateToConfirmView(){
        let storyboard = UIStoryboard(name: "Pix", bundle: nil)
        let pvc = storyboard.instantiateViewController(withIdentifier: "PixConfirmedViewController") as! PixConfirmedViewController
        
        pvc.parentView = self
        present(pvc, animated: true)
    }
}
