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
        toast(message: "Para afins de demonstração, essa funcionalidade está desativada. Utilize o CPF de teste 008.984.872-18 para login.")
    }
    @IBAction func openLoginDialog(_ sender: Any) {
        InputViewController.showInputModal(parentVC: self, payload: InputDetailModel(title: "Digite o CPF", sutitlePlaceholder: "000.000.000-00", minLength: 11, maxLength: 11, allowedCharacters: Presets.NUMERIC_CHARS), sameWindows: false, tag: "CPF")
    }
    
    func onConfirmedText(typedText: String, tag: String) {
        print("typedText")
        print(typedText)
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
        print("login..")
        AuthenticationAPIManager.shared.authenticate(cpf, pass){
            auth in
            
            switch auth{
            case let .success(credentials):
                self.navigateToHome(credentials)
                
            case let .failure(error):
                print("Erro ao autenticar usuario \(error)")
                self.toast(message: "Estamos com alguma instabilidade no sistema. Favor tente novamente")
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
}
