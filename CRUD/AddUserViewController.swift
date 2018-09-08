//
//  AddUserViewController.swift
//  ios_crud_app
//
//  Created by Yoshua Elmaryono on 07/09/18.
//  Copyright © 2018 Yoshua Elmaryono. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUserForm()
    }
    func setupUserForm(){
        let form = UserForm()
        view.addSubview(form)
        form.delegate = self
        
        form.translatesAutoresizingMaskIntoConstraints = false
        form.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        form.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        form.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        form.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

}
extension AddUserViewController: UserFormDelegate {
    func populateTextField() -> String {
        return ""
    }
    func validateText(_ text: String) -> Bool {
        let name_isUnique = names.reduce(true) { (isUnique, name) -> Bool in
            if isUnique == false {return false}
            if name == text {return false}
            return true
        }
        return !text.isEmpty && name_isUnique
    }
    func handleSubmit(user_fullName: String) {
        names.append(user_fullName)
        self.navigationController?.popViewController(animated: true)
    }
}
