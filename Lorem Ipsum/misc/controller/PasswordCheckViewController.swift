//
//  PasswordCheckViewController.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 13/09/21.
//

import UIKit

protocol PasswordDelegate {
    func onPasswordCheck(check:Bool, tag:String)
}

class PasswordCheckViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var passwordCheck: UITextField!
    var tag:String = ""

    let passwordLength = 4
    var delegate: PasswordDelegate?
    
    var passwordMasked = ""
    var retryAmount = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordCheck.delegate = self
        passwordCheck.becomeFirstResponder()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        if(currentText.contains("/")){
            if string == "/"{
                return false
            }
        }
        if(currentText.contains("@")){
            if string == "@"{
                return false
            }
        }
        
        if passwordMasked.count < passwordLength{
            passwordMasked += string
            
        }
        
        var isBackSpace = false
        if let char = string.cString(using: String.Encoding.utf8) {
            isBackSpace = (strcmp(char, "\\b") == -92)
            if (isBackSpace && passwordMasked.count>0) {
                passwordMasked.removeLast()
            }
        }
        
        let amountOfCharacters = passwordMasked.count
        
        validatePassword(amount: amountOfCharacters, password: passwordMasked)
        
        passwordCheck.text = ""
        passwordMasked.forEach { c in
            passwordCheck.text! += "*"
        }
        return false
    }
    
    private func validatePassword(amount: Int, password: String){
        passwordCheck.textColor = UIColor.black
        if amount >= passwordLength{
            let isCorrect = (password == "1234")
            
            if(!isCorrect){
                passwordCheck.textColor = UIColor.red
                passwordCheck.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 5, revert: false)
                
                retryAmount -= 1
                
                if(retryAmount <= 0){
                    dismiss(animated: true) {
                        self.delegate?.onPasswordCheck(check: false, tag: self.tag)
                    }
                }
            }
            else{
                dismiss(animated: true) {
                    self.delegate?.onPasswordCheck(check: true, tag: self.tag)
                }
            }
        }
    }
    
    static func showModal(parentVC: UIViewController, sameWindows:Bool, tag:String){
        let storyboard = UIStoryboard(name: "PasswordCheck", bundle: nil)
        let pvc = storyboard.instantiateViewController(withIdentifier: "PasswordCheckViewController")

        if(sameWindows){
            pvc.modalPresentationStyle = .custom
            pvc.transitioningDelegate = pvc as? UIViewControllerTransitioningDelegate
        }
        
        if let this = pvc as? PasswordCheckViewController{
            this.delegate = parentVC as? PasswordDelegate
            this.tag = tag
        }
        
        parentVC.present(pvc, animated: true)
    }
}
