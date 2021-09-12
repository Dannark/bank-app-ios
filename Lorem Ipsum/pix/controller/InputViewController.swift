//
//  CpfInputViewController.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 12/09/21.
//

import UIKit

protocol PopUpDelegate {
    func onConfirmedText(typedText:String, tag:String)
//    func onValidatingText(typedText:String, replacementString string: String) -> Bool
}

class InputViewController: UIViewController, UIViewControllerTransitioningDelegate, UITextFieldDelegate {

    @IBOutlet var distanceToBottom: NSLayoutConstraint!
    let defaultDistanceToBottom = CGFloat(55)
    let minDistanceToBottom = CGFloat(10)
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var inputField: UITextField!
    @IBOutlet var confimButton: UIButton!
    
    var payload:InputDetailModel?
    var delegate: PopUpDelegate?
    var tag:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let initialData = payload{
            titleLabel.text = initialData.title
            inputField.placeholder = initialData.sutitlePlaceholder
            validateConfirmButton(amount: 0, minLength: payload!.minLength)
        }
        inputField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
//        var shouldTypeText = self.delegate?.onValidatingText(typedText: currentText, replacementString: string) ?? false
        
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
        
        if let payload = payload{
            if CharacterSet(charactersIn: payload.allowedCharacters).isSuperset(of: CharacterSet(charactersIn: string)) {
                
                var fullText = currentText + string
                
                var isBackSpace = false
                if let char = string.cString(using: String.Encoding.utf8) {
                    isBackSpace = (strcmp(char, "\\b") == -92)
                    if isBackSpace {fullText.removeLast()}
                }
                
                let amountOfCharacters = fullText
                    .replacingOccurrences(of: ".", with: "")
                    .replacingOccurrences(of: "/", with: "")
                    .replacingOccurrences(of: "-", with: "").count
                
                validateConfirmButton(amount: amountOfCharacters, minLength: payload.minLength)
                return amountOfCharacters <= payload.maxLength || isBackSpace
            }
        }
        
        return false
    }
    
    private func validateConfirmButton(amount: Int, minLength:Int){
        confimButton.isEnabled = amount >= minLength
        if confimButton.isEnabled{
            confimButton.backgroundColor = UIColor.systemPink
        }
        else{
            confimButton.backgroundColor = UIColor.systemGray5
        }
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true) {
            print("dissmiss")
        }
    }
    @IBAction func confirmButton(_ sender: Any) {
        dismiss(animated: true) {
            if let typed = self.inputField.text{
                self.delegate?.onConfirmedText(typedText: typed, tag: self.tag)
            }
        }
    }
    
    //MARK:- Functions to display modal on bottom
    static func showInputModal(parentVC: UIViewController, payload: InputDetailModel, sameWindows:Bool, tag:String){
        let storyboard = UIStoryboard(name: "Pix", bundle: nil)
        let pvc = storyboard.instantiateViewController(withIdentifier: "InputViewController")

        if(sameWindows){
            pvc.modalPresentationStyle = .custom
            pvc.transitioningDelegate = pvc as? UIViewControllerTransitioningDelegate
        }
        
        if let input = pvc as? InputViewController{
            input.delegate = parentVC as? PopUpDelegate
            input.payload = payload
            input.tag = tag
        }
        
        parentVC.present(pvc, animated: true)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presentingViewController)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc func keyboardWillAppear(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            distanceToBottom.constant = minDistanceToBottom + keyboardHeight
        }
        
    }
    @objc func keyboardWillDisappear() {
        distanceToBottom.constant = defaultDistanceToBottom
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
}

class HalfSizePresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let bounds = containerView?.bounds else { return .zero }
        let y = CGFloat(0)
        return CGRect(x: 0, y: y, width: bounds.width, height: CGFloat(bounds.height))
    }
}
