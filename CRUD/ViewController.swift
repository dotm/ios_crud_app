//
//  ViewController.swift
//  CRUD
//
//  Created by Yoshua Elmaryono on 07/09/18.
//  Copyright © 2018 Yoshua Elmaryono. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private weak var userTableView: UITableView? = nil
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        self.view = view
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigationBar()
        setupUserTableView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: .modelChanged, object: nil)
    }
    @objc func reloadTableView(){
        userTableView?.reloadData()
    }
    private func setupNavigationBar(){
        self.navigationItem.title = "Home"
        
        let addUserButton = UIBarButtonItem(title: "Add User", style: .plain, target: self, action: #selector(presentAddUserForm))
        self.navigationItem.rightBarButtonItem = addUserButton
    }
    @objc func presentAddUserForm(){
        self.navigationController?.pushViewController(AddUserViewController(), animated: true)
    }
    private func setupUserTableView(){
        let userTableView = UITableView()
        view.addSubview(userTableView)
        
        userTableView.dataSource = self
        userTableView.delegate = self
        
        userTableView.translatesAutoresizingMaskIntoConstraints = false
        userTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        userTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        userTableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        self.userTableView = userTableView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "User Cell")
        let index = indexPath.row
        cell.textLabel?.text = names[index]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            names.remove(at: indexPath.row)
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let edit_viewController = EditUserViewController()
        edit_viewController.oldName = names[indexPath.row]
        self.navigationController?.pushViewController(edit_viewController, animated: true)
    }
}
