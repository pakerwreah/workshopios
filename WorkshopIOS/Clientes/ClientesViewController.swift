//
//  ClientesViewController.swift
//  WorkshopIOS
//
//  Created by Paker on 14/2/19.
//  Copyright © 2019 Paker. All rights reserved.
//

import UIKit

var tb_clientes = [
    ["nome": "Sra. Isabella Padrão de Oliveira Sobrinho", "cpf": "705.721.443-00", "celular": "(83) 91734-8695", "email": "rcolaco@example.net"],
    ["nome": "Dr. Emiliano Balestero Marin Sobrinho", "cpf": "865.900.694-17", "celular": "(45) 95599-9050", "email": "jimenes.abgail@example.com"],
    ["nome": "Dr. Alan Fonseca", "cpf": "008.184.966-49", "celular": "(69) 93928-4271", "email": "zlozano@example.net"],
    ["nome": "Srta. Sara Valéria Faro Filho", "cpf": "744.904.921-03", "celular": "(65) 98166-1497", "email": "andrea07@example.com"],
    ["nome": "Dr. Gustavo Josué Rico", "cpf": "831.694.180-50", "celular": "(74) 96814-3325", "email": "mario.marin@example.net"],
    ["nome": "Manuel Domingues Neto", "cpf": "473.291.825-59", "celular": "(54) 93441-4986", "email": "andres.soares@example.com"],
    ["nome": "Samanta Domingues Jr.", "cpf": "309.129.304-11", "celular": "(31) 97545-3293", "email": "rosa.anderson@example.com"],
    ["nome": "Sr. Rodrigo Assunção", "cpf": "586.039.768-21", "celular": "(99) 96394-5163", "email": "mendes.camila@example.org"],
    ["nome": "Dr. Andres Santiago Valência", "cpf": "740.188.758-43", "celular": "(18) 95510-5842", "email": "fsalas@example.org"],
    ["nome": "Srta. Suzana Neves Garcia", "cpf": "869.050.973-90", "celular": "(69) 97518-5620", "email": "matias.lucas@example.net"],
    ["nome": "GELDER PESSOA DA SILVA", "cpf": "447.315.758-00", "celular": "(17) 99618-0050", "email": "gelderpessoa@yahoo.com.br"],
    ["nome": "GELDER PESSOA DA SILVA", "cpf": "447.315.758-00", "celular": "(17) 99618-0050", "email": "gelderpessoa@yahoo.com.br"],
    ["nome": "GEGELDE HHAKD", "cpf": "418.698.518-97", "celular": "(17) 99191-9191", "email": "gelderpessoa@outlook.com.br"]
]

struct Cliente {
    var nome: String
    var cpf: String
    var email: String
    var telefone: String
}

class ClientesViewController: UIViewController {

    @IBOutlet weak var lista: UITableView!

    var dados: [Cliente] {
        get {
            return tb_clientes
                .map { Cliente(nome: $0["nome"]!, cpf: $0["cpf"]!, email: $0["email"]!, telefone: $0["celular"]!)  }
                .sorted(by: { (a, b) -> Bool in
                return a.nome.lowercased() < b.nome.lowercased()
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Clientes"

        lista.register(UINib(nibName: "ClientesCell", bundle: nil), forCellReuseIdentifier: "ClientesCell")

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(abrirCadastro))
    }

    @objc func abrirCadastro() {
        let cadastro = CadastroViewController()
        cadastro.listener = self.reload
        navigationController?.pushViewController(cadastro, animated: true)
    }

    func reload() {
        lista.reloadData()
    }

}

extension ClientesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lista.deselectRow(at: indexPath, animated: true)
    }
}

extension ClientesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dados.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = lista.dequeueReusableCell(withIdentifier: "ClientesCell", for: indexPath) as! ClientesCell

        let item = dados[indexPath.row]

        cell.nome.text = item.nome
        cell.email.text = item.email
        cell.cpf.text = item.cpf
        cell.telefone.text = item.telefone

        return cell
    }
}
