//
//  CadastroViewController.swift
//  WorkshopIOS
//
//  Created by Paker on 14/2/19.
//  Copyright © 2019 Paker. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {

    @IBOutlet weak var txt_nome: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_cpf: UITextField!
    @IBOutlet weak var txt_telefone: UITextField!

    var listener: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Cadastro"
    }

    @IBAction func salvar(_ sender: Any) {
        let nome = txt_nome.text!.trim()
        let cpf = txt_cpf.text!.trim()
        let email = txt_email.text!.trim()
        let telefone = txt_telefone.text!.trim()

        let valid = [nome, cpf, email, telefone].allSatisfy { !$0.isEmpty }

        if(valid) {
            tb_clientes.append(["nome": nome, "cpf": cpf, "celular": telefone, "email": email])
            listener?()
            navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Alert", message: "Preencha todos os campos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension String {
    func trim() -> String {
        return trimmingCharacters(in: CharacterSet.whitespaces)
    }
}
