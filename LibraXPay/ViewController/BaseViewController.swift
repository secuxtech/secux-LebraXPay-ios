//
//  BaseViewController.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/11/8.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import UIKit
import JGProgressHUD


class BaseViewController: UIViewController {
    
    
    var theProgress  = JGProgressHUD(style: .dark)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UISetting.shared.vcBKColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        /*
        Setting.shared.hasInternet.addObserver({ (value) in
            if !value{
                
                self.showMessage(title: "No internet connection!", message: "Please check the Wifi")
            }
            
        })
        */
        
        //let tt = Setting.shared.hasInternet.value
        
        if !Setting.shared.hasInternet.value{
            self.showMessageInMainThread(title: "No internet connection!", message: "Please check the Wifi")
        }
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    func showMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMessageInMainThread(title: String, message: String){
        DispatchQueue.main.async {
            self.showMessage(title: title, message: message)
        }
    }
    
    
    
    func isProgressVisible() -> Bool{
        return !self.theProgress.isHidden
        
    }
    
    func hideProgress(){
        
        DispatchQueue.main.async {
        
            
            self.theProgress.dismiss()
            self.navigationController?.navigationBar.isUserInteractionEnabled = true
            self.tabBarController?.tabBar.isUserInteractionEnabled = true
        }
    }
    
    func showProgress(info: String){
        
        DispatchQueue.main.async {
            
            self.tabBarController?.tabBar.isUserInteractionEnabled = false
            self.navigationController?.navigationBar.isUserInteractionEnabled = false
            
            self.theProgress.textLabel.text = NSLocalizedString(info, comment: "")
            self.theProgress.show(in: self.view)
        }
    }
    
    
    func updateProgress(info: String){
        DispatchQueue.main.async {
            self.theProgress.textLabel.text = NSLocalizedString(info, comment: "")
        }
    }
    
    func handleUnauthorizedError(){
        DispatchQueue.main.async {
         
            let rootVC = LoginViewController();
            rootVC.modalPresentationStyle = .overFullScreen
            self.present(rootVC, animated: true)
            
        }
    }
    
    func logout(){
        DispatchQueue.main.async {
         
            let rootVC = LoginAndRegisterViewController();
            rootVC.modalPresentationStyle = .overFullScreen
            self.present(rootVC, animated: true)
            
        }
    }
}

