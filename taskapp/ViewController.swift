//
//  ViewController.swift
//  taskapp
//
//  Created by Guilherme on 06/12/2017.
//  Copyright © 2017 Guilherme. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var token: Token?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func doLogin(_ sender: Any) {
        
        if txtUser.text == "" {
            showMessage("Login invalido")
            return
        }
        if txtPassword.text ==  "" {
            showMessage("Senha invalida")
            return
        }
        
        
        PostService().login(username: self.txtUser.text!, password: self.txtPassword.text!, onSuccess: { response in
            
            self.token = response?.body
            
            print("Login do usuario '\(String(describing: self.txtUser.text))' realizado com sucesso")
            self.performSegue(withIdentifier: "navLogin", sender: self.token)
            print("Token: \(String(describing: self.token))")
            
            print("Access Token: \(self.token?.accessToken)")
            
            UserDefaults.standard.set(self.token?.accessToken, forKey: AppConfig.TOKEN_LOGADO)
            UserDefaults.standard.synchronize()
            
        }, onError: { _ in
            
            print("Falha ao realizar login para o usuario '\(String(describing: self.txtUser.text))'")
            self.showMessage("Login ou Senha invalido(s)")
            
        }, always: {
            //hide loading
        })
        
        
    }
    
    
    func showMessage(_ msg:String) {
        let myalert = UIAlertController(title: "Mensagem", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        myalert.addAction(UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction!) in
            
            myalert.dismiss(animated: true)
        })
        self.present(myalert, animated: true)
    }


}

