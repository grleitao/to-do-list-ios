//
//  RegisterViewController.swift
//  ToDoList
//
//  Created by Gustavo Rodrigues Leitao on 24/11/24.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Crie sua conta para acessar o To-Do List"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-mail"
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setLeftPadding(10)
        textField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return textField
    }()
    
    private let confirmEmailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirmar E-mail"
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setLeftPadding(10)
        textField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Crie a senha"
        textField.isSecureTextEntry = true
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setLeftPadding(10)
        textField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return textField
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirme a senha"
        textField.isSecureTextEntry = true
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setLeftPadding(10)
        textField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Registrar", for: .normal)
        button.backgroundColor = UIColor(red: 24/255, green: 119/255, blue: 242/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.backgroundColor = UIColor.lightGray
        return button
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextFieldObservers()
        configureActions()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(emailTextField)
        contentView.addSubview(confirmEmailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(confirmPasswordTextField)
        contentView.addSubview(registerButton)
        
        // Layout
        NSLayoutConstraint.activate([
            // ScrollView e contentView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Título
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Campos de texto
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            confirmEmailTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            confirmEmailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            confirmEmailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: confirmEmailTextField.bottomAnchor, constant: 15),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            registerButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 30),
            registerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            registerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupTextFieldObservers() {
        emailTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        confirmEmailTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    }
    
    @objc private func handleTextInputChange() {
        let isFormValid = !(emailTextField.text?.isEmpty ?? true) &&
        !(confirmEmailTextField.text?.isEmpty ?? true) &&
        !(passwordTextField.text?.isEmpty ?? true) &&
        !(confirmPasswordTextField.text?.isEmpty ?? true)
        
        registerButton.isEnabled = isFormValid
        registerButton.backgroundColor = isFormValid
        ? UIColor(red: 24/255, green: 119/255, blue: 242/255, alpha: 1)
        : UIColor.lightGray
    }
    
    private func configureActions() {
        registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
    }
    
    
    @objc private func handleRegister() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        let tabBarVC = TabBarController()
        
        let options: UIView.AnimationOptions = .transitionFlipFromRight
        UIView.transition(with: window, duration: 0.5, options: options, animations: {
            window.rootViewController = tabBarVC
        }, completion: nil)
    }
}

