//
//  CustomNavigationController.swift
//  ToDoList
//
//  Created by Gustavo Rodrigues Leitao on 24/11/24.
//

import UIKit

class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        // Configuração de cores
        navigationBar.tintColor = .white // Cor dos ícones e textos
        navigationBar.barTintColor = UIColor(red: 24/255, green: 119/255, blue: 242/255, alpha: 1) // Cor de fundo
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white, // Cor do título
            .font: UIFont.boldSystemFont(ofSize: 18) // Fonte do título
        ]
    }
}
