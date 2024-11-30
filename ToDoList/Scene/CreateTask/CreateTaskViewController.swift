import UIKit

class CreateTaskViewController: UIViewController {
    
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
        label.text = "Criar Nova Tarefa"
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
        textView.text = "Descrição"
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .lightGray
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return textView
    }()
    
    private let createTaskButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Criar Tarefa", for: .normal)
        button.backgroundColor = UIColor(red: 24/255, green: 119/255, blue: 242/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: CreateTaskDelegate?

    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureActions()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(taskTitleTextField)
        contentView.addSubview(dateTextField)
        contentView.addSubview(timeTextField)
        contentView.addSubview(descriptionTextView)
        contentView.addSubview(createTaskButton)
        
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
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Campos de texto
            taskTitleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            taskTitleTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            taskTitleTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            dateTextField.topAnchor.constraint(equalTo: taskTitleTextField.bottomAnchor, constant: 15),
            dateTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            timeTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 15),
            timeTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            timeTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionTextView.topAnchor.constraint(equalTo: timeTextField.bottomAnchor, constant: 15),
            descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Botão
            createTaskButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 30),
            createTaskButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            createTaskButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            createTaskButton.heightAnchor.constraint(equalToConstant: 50),
            createTaskButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func configureActions() {
        createTaskButton.addTarget(self, action: #selector(handleCreateTask), for: .touchUpInside)
    }
    
    @objc private func handleCreateTask() {
        let newTask = ToDoItem(title: taskTitleTextField.text ?? "" , subtitle: descriptionTextView.text ?? "", date: dateTextField.text ?? "")
        
        delegate?.didCreateTask(newTask)
        
        navigationController?.popViewController(animated: true)
    }
}

protocol CreateTaskDelegate: AnyObject {
    func didCreateTask(_ task: ToDoItem)
}
