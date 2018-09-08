//
//  UserForm.swift
//  CRUD
//
//  Created by Yoshua Elmaryono on 07/09/18.
//  Copyright © 2018 Yoshua Elmaryono. All rights reserved.
//

import UIKit

protocol UserFormDelegate {
    func validateText(_ text: String) -> Bool
    func handleSubmit(user_fullName: String)
    func populateTextField() -> String
}

class UserForm: UIView {
    private weak var textField: UITextField!
    private var button: UIButton!
    var delegate: UserFormDelegate! {
        didSet {
            textField.text = delegate.populateTextField()
        }
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupForm()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupForm()
    }
    
    func setupForm(){
        setupTextField()
        setupButton()
        
        let stackView = UIStackView()
        self.addSubview(stackView)
        
        stackView.addArrangedSubview(self.textField)
        stackView.addArrangedSubview(self.button)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = CGFloat(10)
        
        stackView.subviews.forEach { (subview) in
            subview.translatesAutoresizingMaskIntoConstraints = false
            subview.heightAnchor.constraint(equalToConstant: 35).isActive = true
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    func setupTextField(){
        let textField = UITextField()
        
        textField.delegate = self
        print(delegate)
        textField.placeholder = "User Full Name"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = .bezel
        textField.autocorrectionType = .no
        textField.keyboardType = .default
        textField.returnKeyType = .done
        
        self.textField = textField
    }
    func setupButton(){
        let button = UIButton()
        
        button.setTitle("Done", for: .normal)
        button.setTitle("Please enter a valid name", for: .disabled)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0.8, alpha: 1), for: .normal)
        button.setTitleColor(UIColor(red: 0.3, green: 0.3, blue: 0.8, alpha: 1), for: .highlighted)
        button.setTitleColor(UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), for: .disabled)
        button.addTarget(self, action: #selector(buttonPressedHandler), for: .touchUpInside)
        button.isEnabled = false
        
        self.button = button
    }
    
    @objc func buttonPressedHandler(_ sender: UIButton){
        textField.resignFirstResponder()
        
        guard let text = textField.text else {
            return
        }
        let text_isValid = delegate.validateText(text)
        if text_isValid {
            delegate.handleSubmit(user_fullName: text)
        } else {
            return
        }
    }
}

extension UserForm: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        let text_isValid = delegate.validateText(text)
        if text_isValid {
            button.isEnabled = true
        } else {
            button.isEnabled = false
        }
    }
}
