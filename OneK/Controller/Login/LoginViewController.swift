//
//  LoginViewController.swift
//  OneK
//
//  Created by BCMM on 25/01/2022.
//

import UIKit

class LoginViewController: UIViewController {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var btnCheckbox: UIButton!
    
    var isSelected:Bool = false
    
    @IBOutlet weak var lblTnC: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField()
        setupTermandCondition()
        btnLogin.isUserInteractionEnabled = false
        btnLogin.backgroundColor = UIColor.init(red: 164/255, green: 207/255, blue: 136/255, alpha: 1)
        
    }
    
   
    
    
    @IBAction func clickCheckBox(_ sender: Any) {
        
        if isSelected != true {
            btnCheckbox.setBackgroundImage(UIImage(named: "rightCheck"), for: .normal)
            isSelected = true
            isCanLogin()
        }else{
            btnCheckbox.setBackgroundImage(UIImage(named: ""), for: .normal)
            isSelected = false
            isCanLogin()
        }
    }
    
    func setupTextField(){
        phoneNumberTextField.delegate = self
        passwordTextField.delegate = self
        phoneNumberTextField.leftViewMode = .always
        let phoneImageView = UIImageView()
        let phoneImage = UIImage(named: "smartPhone")
        phoneImageView.image = phoneImage
        phoneImageView.contentMode = .scaleToFill
        
        phoneImageView.frame = CGRect(x: 5, y: 0, width: 10, height: 10)
        phoneNumberTextField.leftView = phoneImageView
        let phoneUnderLine = UIView()
        view.addSubview(phoneUnderLine)
        phoneUnderLine.backgroundColor = .gray
        phoneUnderLine.anchor(top: phoneNumberTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 1, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 1)
        
        passwordTextField.leftViewMode = .always
        let lockImageView = UIImageView()
        let lockImage = UIImage(named: "lock")
        lockImageView.image = lockImage
        lockImageView.contentMode = .scaleToFill
        
        lockImageView.frame = CGRect(x: 5, y: 0, width: 10, height: 10)
        passwordTextField.leftView = lockImageView
        passwordTextField.isSecureTextEntry = true
        let passwordUnderLine = UIView()
        view.addSubview(passwordUnderLine)
        passwordUnderLine.backgroundColor = .gray
        passwordUnderLine.anchor(top: passwordTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 1, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 1)
        
        
        btnLogin.layer.cornerRadius = 2
    }
    
    func setupTermandCondition(){
       
        let textString = "Agree to our Terms & Conditions"
            let range = (textString as NSString).range(of: "Terms & Conditions")
            let attributedString = NSMutableAttributedString(string: textString)

        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: range)
            self.lblTnC.attributedText = attributedString

        lblTnC.attributedText = attributedString
        lblTnC.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        lblTnC.addGestureRecognizer(tapgesture)
    }
    
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer){
        guard let text = self.lblTnC.text else { return }
        let conditionsRange = (text as NSString).range(of: "Terms & Conditions")

        if gesture.didTapAttributedTextInLabel(label: self.lblTnC, inRange: conditionsRange) {
            if let url = URL(string: "https://www.onekyat.com/") {
                UIApplication.shared.open(url)
            }

        }
    }
    
    
    
    @IBAction func loginOneKyat(_ sender: Any) {
        
        validationCheck()
    }
    
    func validationCheck(){
        
        if phoneNumberTextField.text == "09420000001" && passwordTextField.text == "password_123$#" {
            defaults.setValue(true, forKey: "isLogin")
            dismiss(animated: false, completion: nil)
        }else{
            // Create a new alert
            let dialogMessage = UIAlertController(title: "Login Alert", message: "Phone Number and Passwowrd Do Not Match Please Try Again!", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
             })
            dialogMessage.addAction(ok)
            // Present alert to user
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    func isCanLogin(){
        if phoneNumberTextField.text != "" && passwordTextField.text != "" && isSelected != false {
            btnLogin.isUserInteractionEnabled = true
            btnLogin.backgroundColor = UIColor.systemGreen
        }else{
            btnLogin.isUserInteractionEnabled = false
            btnLogin.backgroundColor = UIColor.init(red: 164/255, green: 207/255, blue: 136/255, alpha: 1)
        }
    }

}

extension NSMutableAttributedString {

    public func setAsLink(textToFind:String, linkURL:String) -> Bool {

        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}

extension LoginViewController:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == phoneNumberTextField{
            if passwordTextField.text != "" && isSelected != false{
                btnLogin.isUserInteractionEnabled = true
                btnLogin.backgroundColor = UIColor.systemGreen
            }
        }else if textField == passwordTextField{
            if phoneNumberTextField.text != "" && isSelected != false{
                btnLogin.isUserInteractionEnabled = true
                btnLogin.backgroundColor = UIColor.systemGreen
            }
        }

        
       }
    
    
    
    
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = NSLineBreakMode.byWordWrapping
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y);
        var indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        indexOfCharacter = indexOfCharacter + 4
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
