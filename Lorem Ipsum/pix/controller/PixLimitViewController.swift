//
//  PixAjusteDeLimiteViewController.swift
//  Lorem Bank
//
//  Created by Daniel Queiroz on 13/09/21.
//

import UIKit

class PixLimitViewController: UIViewController, PasswordDelegate {

    @IBOutlet var ajusteLimitePix: UILabel!
    @IBOutlet var slider: UISlider!
    @IBOutlet var adjustLimitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        slider.value = 20000
    }
    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .moved:
                limiteSliderStepAt(100)
                ajusteLimitePix.text = getFormattedPrice()
                validateButton()
            default:
                break
            }
        }
    }
    
    private func limiteSliderStepAt(_ step:Float){
        let roundedValue = round(slider.value / step) * step
        slider.value = roundedValue
    }
    
    private func validateButton(){
        adjustLimitButton.isEnabled = (slider.value != 0)
        if adjustLimitButton.isEnabled{
            adjustLimitButton.backgroundColor = UIColor.systemPink
        }
        else{
            adjustLimitButton.backgroundColor = UIColor.systemGray5
        }
    }
    
    private func getFormattedPrice() -> String{
        return "R$ " + "\(Int(slider.value))".toPrice()
    }
    @IBAction func confirmAdjustPixLimit(_ sender: Any) {
        PasswordCheckViewController.showModal(parentVC: self, sameWindows: true, tag: "CHECKPASSWORD")
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func onPasswordCheck(check: Bool, tag: String) {
        if check {
            toToConfirmWindows()
        }
    }
    
    private func toToConfirmWindows(){
        let storyboard = UIStoryboard(name: "LimitPix", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PixLimitConfirmedViewController") as! PixLimitConfirmedViewController
        
        vc.parentVC = self
        navigationController?.present(vc, animated: true, completion: nil)
    }
}
