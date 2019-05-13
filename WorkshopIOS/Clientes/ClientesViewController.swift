//
//  ClientesViewController.swift
//  WorkshopIOS
//
//  Created by Paker on 14/2/19.
//  Copyright © 2019 Paker. All rights reserved.
//

import UIKit

struct Cliente {
    var nome: String
    var cpf: String
    var email: String
    var telefone: String
}

class ClientesViewController: UIViewController {

    @IBOutlet weak var lista: UITableView!

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red

        return refreshControl
    }()

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.reload()
            refreshControl.endRefreshing()
        }
    }

    private var searchText = ""

    var dados = [Cliente]()

    func getDados() -> [Cliente] {
        let predicate = NSPredicate(format: "(%@.length == 0 OR nome contains[cd] %@) AND ativo = %@", searchText, searchText, NSNumber(booleanLiteral: true))

        return tb_clientes
            .filter { predicate.evaluate(with: $0) }
            .map { Cliente(nome: $0["nome"] as! String, cpf: $0["cpf"] as! String, email: $0["email"] as! String, telefone: $0["celular"] as! String) }
            .sorted(by: { (a, b) -> Bool in
                return a.nome.lowercased() < b.nome.lowercased()
            })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Clientes"

        lista.register(UINib(nibName: "ClientesCell", bundle: nil), forCellReuseIdentifier: "ClientesCell")

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(abrirCadastro))

        lista.addSubview(refreshControl)

        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: .RecarregarClientes, object: nil)

        reload()
    }

    @objc func abrirCadastro() {
        let cadastro = CadastroViewController()
        cadastro.listener = self.reload
        navigationController?.pushViewController(cadastro, animated: true)
    }

    @objc func reload() {
        dados = getDados()
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

extension ClientesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        reload()
    }
}
