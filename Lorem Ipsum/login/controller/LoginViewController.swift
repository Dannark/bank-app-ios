//
//  LoginViewController.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 14/09/21.
//

import UIKit

class LoginViewController: UIViewController, PopUpDelegate {
    
    private var holdCPF = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func createAccount(_ sender: Any) {
        toast(message: "Para afins de demonstração, essa funcionalidade está desativada. Utilize o CPF de teste 008.984.872-18 ou 000.111.222.33 para login, e senha 12345678 para ambos")
    }
    @IBAction func openLoginDialog(_ sender: Any) {
        InputViewController.showInputModal(parentVC: self, payload: InputDetailModel(title: "Digite o CPF", sutitlePlaceholder: "000.000.000-00", minLength: 11, maxLength: 11, allowedCharacters: Presets.NUMERIC_CHARS), sameWindows: false, tag: "CPF")
    }
    
    func onConfirmedText(typedText: String, tag: String) {
        switch tag {
        case "CPF":
            holdCPF = typedText
            InputViewController.showInputModal(parentVC: self, payload: InputDetailModel(title: "Digite sua Senha",
                                                                         sutitlePlaceholder: "****",
                                                                         minLength: 8,
                                                                         maxLength: 16,
                                                                         allowedCharacters: Presets.EMAIL_CHARS,
                                                                         passwordMask: true), sameWindows: false, tag: "PASSWORD")
        case "PASSWORD":
            authenticate(holdCPF, typedText)
        default:
            print("action not found")
        }
        
    }
    
    private func authenticate(_ cpf: String, _ pass:String){
        print("fazendo login..")
        AuthenticationAPIManager.shared.authenticate(cpf, pass){
            credentials, errorMsg in
            
            if let credentials = credentials{
                self.navigateToHome(credentials)
            }
            else{
                if let errorMsg = errorMsg{
                    self.showError(error: errorMsg)
                }
                else{
                    print("Um evento de proporções catastroficas e inimaginaveis aconteceu... \(credentials) | \(errorMsg)")
                }
            }
            
        }
    }
    
    private func navigateToHome(_ credentials: AuthenticationModel){
        DispatchQueue.main.async {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Home")
            
            self.show(nextViewController, sender: self)
        }
    }
    
    private func showError(error:String){
        DispatchQueue.main.async {
            self.toast(message: error)
        }
    }
}
