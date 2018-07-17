//
//  AccountTableViewController.swift
//  Playlist
//
//  Created by DONGHYUN KIM on 2018. 7. 16..
//  Copyright © 2018년 dorenza. All rights reserved.
//

import UIKit
import FirebaseUI

class AccountTableViewController: UITableViewController, FUIAuthDelegate, LoginTableViewCellDelegate {
    
    private var authUI: FUIAuth!
    private var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let providers: [FUIAuthProvider] = [FUIGoogleAuth()]
        authUI = FUIAuth.defaultAuthUI()
        authUI.providers = providers
        authUI.isSignInWithEmailHidden = true
        authUI.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = authUI.auth?.addStateDidChangeListener() { (auth, user) in
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if handle != nil {
            authUI.auth?.removeStateDidChangeListener(handle!)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "title cell", for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "login cell", for: indexPath)
        
        if let loginCell = cell as? LoginTableViewCell {
            loginCell.delegate = self
            if let currentTitle = loginCell.loginButton.attributedTitle(for: .normal) {
                let loginButtonTitle = NSMutableAttributedString(attributedString: currentTitle)
                
                if let user = authUI.auth?.currentUser {
                    loginButtonTitle.mutableString.setString("로그아웃")
                    loginCell.loginButton.setAttributedTitle(loginButtonTitle as NSAttributedString, for: .normal)
                    loginCell.descriptionLabel.isHidden = true
                    loginCell.loginModeLabel.text = user.email
                } else {
                    loginButtonTitle.mutableString.setString("로그인")
                    loginCell.loginButton.setAttributedTitle(loginButtonTitle as NSAttributedString, for: .normal)
                    loginCell.descriptionLabel.isHidden = false
                    loginCell.loginModeLabel.text = "게스트 모드"
                }
            }
        }
        // Configure the cell...

        return cell
    }

    // MARK: Firebase
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }
    
    func login() {
        if authUI.auth?.currentUser == nil {
            let authViewController = authUI.authViewController()
            show(authViewController, sender: self)
        } else {
            try? authUI.signOut()
        }
    }
}
