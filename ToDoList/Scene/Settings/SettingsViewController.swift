//
//  SettingsViewController.swift
//  ToDoList
//
//  Created by Gustavo Rodrigues Leitao on 24/11/24.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    
    let options = ["Sair"]  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Configurações"
        view.backgroundColor = .white
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "OptionCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        
        // Adicionando o ícone à esquerda da célula
        let logoutImage = UIImage(systemName: "arrow.right.circle.fill") // Ícone indicando saída
        cell.imageView?.image = logoutImage
        cell.imageView?.tintColor = .systemRed // Para o ícone ter uma cor vermelha, por exemplo.
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {  // Se a célula "Deslogar" for selecionada
            logout()
        }
    }
    
    func logout() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        let tabBarVC = LoginViewController()
        
        // Animação de transição para a nova rootViewController
        let options: UIView.AnimationOptions = .transitionFlipFromRight
        UIView.transition(with: window, duration: 0.5, options: options, animations: {
            window.rootViewController = tabBarVC
        }, completion: nil)
     }

}
