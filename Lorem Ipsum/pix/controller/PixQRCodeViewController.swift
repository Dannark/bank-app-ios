//
//  PixQRCodeViewController.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 14/09/21.
//

import UIKit

class PixQRCodeViewController: UIViewController {

    @IBOutlet var qrCodeImage: UIImageView!
    @IBOutlet var qrDescription: UILabel!
    
    var qrCodeString: String = "error"
    var qrValue:String = "R$ 0,00"
    
    var parentVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateQRCode()
    }
    
    func generateQRCode(){
        qrCodeImage.image = Utils.generateQRCode(from: qrCodeString)
        
        if qrValue == "R$ 0,00"{
            qrDescription.text = "O valor será definido pela pessoa que fizer a transferência do pix"
        }
        else{
            qrDescription.text = qrValue
        }
    }
    
    @IBAction func copyCQCode(_ sender: Any) {
        UIPasteboard.general.string = qrCodeString
        toast(message: "Copiado para area de transferência")
    }
    @IBAction func shareQRCode(_ sender: Any) {
        shareImage(image: qrCodeImage.image)
    }
    @IBAction func confirmButton(_ sender: Any) {
        self.parentVC?.navigationController?.popToRootViewController(animated: false)
        dismiss(animated: true) {
            
        }
    }
    
}
