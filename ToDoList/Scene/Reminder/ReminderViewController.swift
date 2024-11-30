import UIKit

protocol ReminderViewControllerDelegate: AnyObject {
    func didSaveReminder(_ item: ToDoItem)
}

class ReminderViewController: UIViewController {
    
    weak var delegate: ReminderViewControllerDelegate?
    var toDoItem: ToDoItem?
    
    let titleField = UITextField()
    let subtitleField = UITextField()
    let dateField = UITextField()
    let saveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        
        if let item = toDoItem {
            titleField.text = item.title
            subtitleField.text = item.subtitle
            dateField.text = item.date
        }
    }
    
    private func setupUI() {
        titleField.placeholder = "Título"
        subtitleField.placeholder = "Subtítulo"
        dateField.placeholder = "Data"
        saveButton.setTitle("Salvar", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        titleField.translatesAutoresizingMaskIntoConstraints = false
        subtitleField.translatesAutoresizingMaskIntoConstraints = false
        dateField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleField)
        view.addSubview(subtitleField)
        view.addSubview(dateField)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            subtitleField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 20),
            subtitleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            dateField.topAnchor.constraint(equalTo: subtitleField.bottomAnchor, constant: 20),
            dateField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveButton.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 40),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func saveButtonTapped() {
        guard let title = titleField.text, !title.isEmpty,
              let subtitle = subtitleField.text, !subtitle.isEmpty,
              let date = dateField.text, !date.isEmpty else {
            return
        }
        
        let newItem = ToDoItem(title: title, subtitle: subtitle, date: date)
        delegate?.didSaveReminder(newItem)
        navigationController?.popViewController(animated: true)
    }
}
