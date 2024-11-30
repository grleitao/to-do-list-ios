//
//  EditTaskViewController.swift
//  ToDoList
//
//  Created by Gustavo Rodrigues Leitao on 29/11/24.
//

import UIKit

class EditTaskViewController: UIViewController {
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Editar Tarefa"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let taskTitleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Título da tarefa"
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
    
    private let dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Data (DD/MM/AAAA)"
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
    
    private let timeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Horário (HH:MM)"
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
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .darkGray
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return textView
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Salvar", for: .normal)
        button.backgroundColor = UIColor(red: 24/255, green: 119/255, blue: 242/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    var toDoItem: ToDoItem?
    var onSave: ((ToDoItem) -> Void)?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureFields()
        configureActions()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(taskTitleTextField)
        view.addSubview(dateTextField)
        view.addSubview(timeTextField)
        view.addSubview(descriptionTextView)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Task Title
            taskTitleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            taskTitleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            taskTitleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Date Field
            dateTextField.topAnchor.constraint(equalTo: taskTitleTextField.bottomAnchor, constant: 15),
            dateTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Time Field
            timeTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 15),
            timeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Description
            descriptionTextView.topAnchor.constraint(equalTo: timeTextField.bottomAnchor, constant: 15),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Save Button
            saveButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureFields() {
        guard let toDoItem = toDoItem else { return }
        taskTitleTextField.text = toDoItem.title
        dateTextField.text = toDoItem.date
        descriptionTextView.text = toDoItem.subtitle
    }
    
    private func configureActions() {
        saveButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
    }
    
    @objc private func handleSave() {
        guard let title = taskTitleTextField.text,
              let date = dateTextField.text,
              let description = descriptionTextView.text else {
            return
        }
        
        let updatedItem = ToDoItem(title: title, subtitle: description, date: date)
        onSave?(updatedItem)
        navigationController?.popViewController(animated: true)
    }
}
