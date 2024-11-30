//
//  CustomTextField.swift
//  ToDoList
//
//  Created by Gustavo Rodrigues Leitao on 24/11/24.
//

import UIKit

class CustomTextField: UITextField {
    
    // Inicializadores
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }
    
    // Configuração do estilo
    private func setupStyle() {
        self.borderStyle = .none
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = UIColor(white: 0.95, alpha: 1)
        self.font = UIFont.systemFont(ofSize: 16)
//        self.setLeftPadding(10)
        self.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
}

// Extensão para adicionar padding interno no lado esquerdo
extension UITextField {
    func setLeftPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
