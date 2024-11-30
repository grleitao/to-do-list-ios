import UIKit

class ToDoItem {
    var title: String
    var subtitle: String
    var date: String
    
    init(title: String, subtitle: String, date: String) {
        self.title = title
        self.subtitle = subtitle
        self.date = date
    }
}

class HomeViewControler: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let createButton = UIButton(type: .system)
    
    var toDoItems = [
        ToDoItem(title: "Comprar fralda", subtitle: "Subtitulo", date: "10/02/2024 22:40"),
        ToDoItem(title: "Comprar Shampoo", subtitle: "Subtitulo", date: "10/02/2024 22:40"),
        ToDoItem(title: "Comprar fralda", subtitle: "Subtitulo", date: "10/02/2024 22:40"),
        ToDoItem(title: "Pagar contas", subtitle: "Água, luz, internet", date: "11/02/2024 10:00"),
        ToDoItem(title: "Fazer compras", subtitle: "Mercado", date: "11/02/2024 14:30"),
        ToDoItem(title: "Ir ao médico", subtitle: "Consulta de rotina", date: "12/02/2024 09:00"),
        ToDoItem(title: "Comprar presente para Maria", subtitle: "Aniversário", date: "12/02/2024 15:00"),
        ToDoItem(title: "Lavar o carro", subtitle: "Interiores e exteriores", date: "13/02/2024 08:00"),
        ToDoItem(title: "Reunião com equipe", subtitle: "Discutir projetos", date: "13/02/2024 11:00"),
        ToDoItem(title: "Limpar a casa", subtitle: "Sala, cozinha e banheiro", date: "13/02/2024 16:00"),
        ToDoItem(title: "Estudar para a prova", subtitle: "Matemática", date: "14/02/2024 19:00"),
        ToDoItem(title: "Pegar encomenda", subtitle: "Correios", date: "14/02/2024 12:00"),
        ToDoItem(title: "Ver filme com amigos", subtitle: "Netflix", date: "14/02/2024 20:30"),
        ToDoItem(title: "Fazer reserva para o jantar", subtitle: "Restaurante X", date: "15/02/2024 18:00"),
        ToDoItem(title: "Levar cachorro ao veterinário", subtitle: "Check-up", date: "15/02/2024 10:00"),
        ToDoItem(title: "Comprar ingressos para show", subtitle: "Banda Y", date: "15/02/2024 14:00"),
        ToDoItem(title: "Reorganizar o guarda-roupa", subtitle: "Roupas de inverno", date: "16/02/2024 09:00"),
        ToDoItem(title: "Fazer backup do computador", subtitle: "Documentos e fotos", date: "16/02/2024 13:00"),
        ToDoItem(title: "Agendar consulta de dentista", subtitle: "Check-up dental", date: "17/02/2024 11:30"),
        ToDoItem(title: "Comprar material escolar", subtitle: "Caderno, canetas, etc.", date: "17/02/2024 16:00")
    ]
    
    
    var filteredToDoItems: [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "To-Do List"
        
        filteredToDoItems = toDoItems
        
        setupSearchBar()
        setupTableView()
        setupCreateButton()
        createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }
    
    func setupSearchBar() {
        searchBar.placeholder = "Buscar"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ])
    }
    
    func setupCreateButton() {
        createButton.setTitle("+ Criar", for: .normal)
        createButton.backgroundColor = .systemBlue
        createButton.setTitleColor(.white, for: .normal)
        createButton.layer.cornerRadius = 25
        createButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createButton)
        
        NSLayoutConstraint.activate([
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createButton.widthAnchor.constraint(equalToConstant: 100),
            createButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredToDoItems = toDoItems
        } else {
            filteredToDoItems = toDoItems.filter { item in
                item.title.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredToDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        let item = filteredToDoItems[indexPath.row]
        cell.configure(title: item.title, subtitle: item.subtitle, date: item.date)
        
        cell.deleteButtonAction = { [weak self] in
            self?.deleteItem(at: indexPath)
        }
        
        cell.editButtonAction = { [weak self] in
            self?.editItem(at: indexPath)
        }
        
        cell.checkButtonAction = { [weak self] in
            self?.completeItem(at: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func deleteItem(at indexPath: IndexPath) {
        let itemToDelete = filteredToDoItems[indexPath.row]  //
        
        if let index = toDoItems.firstIndex(where: { item in
            return item.title == itemToDelete.title && item.date == itemToDelete.date
        }) {
            toDoItems.remove(at: index)
            
            filteredToDoItems = toDoItems
            
            tableView.reloadData()
            
            showSnackbar(message: "Tarefa excluída com sucesso!")
        }
    }
    
    // MARK: - Edit Item
    func editItem(at indexPath: IndexPath) {
        let itemToEdit = filteredToDoItems[indexPath.row]
        let editVC = EditTaskViewController()
        editVC.toDoItem = itemToEdit
        
        editVC.onSave = { [weak self] updatedItem in
            if let index = self?.toDoItems.firstIndex(where: { $0.title == itemToEdit.title && $0.date == itemToEdit.date }) {
                self?.toDoItems[index] = updatedItem
                self?.filteredToDoItems = self?.toDoItems ?? []
                self?.tableView.reloadData()
                self?.showSnackbar(message: "Tarefa atualizada com sucesso!")
            }
        }
        
        navigationController?.pushViewController(editVC, animated: true)

    }

    // MARK: - Complete Item
    func completeItem(at indexPath: IndexPath) {
        let itemToComplete = filteredToDoItems[indexPath.row]
        
        if let index = toDoItems.firstIndex(where: { item in
            return item.title == itemToComplete.title && item.date == itemToComplete.date
        }) {
            toDoItems.remove(at: index)

            filteredToDoItems = toDoItems
            
 
            tableView.reloadData()
            
            showSnackbar(message: "Tarefa concluída com sucesso!")
        }
    }
    
    // MARK: - Show Snackbar
    func showSnackbar(message: String) {
        let snackbar = UIView()
        snackbar.backgroundColor = UIColor.systemGreen
        snackbar.layer.cornerRadius = 10
        snackbar.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = message
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        snackbar.addSubview(label)
        
        view.addSubview(snackbar)
        
        NSLayoutConstraint.activate([
            snackbar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            snackbar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            snackbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            snackbar.heightAnchor.constraint(equalToConstant: 50),
            
            label.centerXAnchor.constraint(equalTo: snackbar.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: snackbar.centerYAnchor)
        ])
        
        // Animação de aparecer e desaparecer
        UIView.animate(withDuration: 0.5, animations: {
            snackbar.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 2.0, options: [], animations: {
                snackbar.alpha = 0.0
            }) { _ in
                snackbar.removeFromSuperview()
            }
        }
    }
    
    @objc private func createButtonTapped() {
        let createTaskVC = CreateTaskViewController()
        createTaskVC.delegate = self
        navigationController?.pushViewController(createTaskVC, animated: true)
    }
}

extension HomeViewControler: CreateTaskDelegate {
    func didCreateTask(_ task: ToDoItem) {
        toDoItems.append(task)
        filteredToDoItems.append(task)
        tableView.reloadData()
        
        showSnackbar(message: "Nova Tarefa adicionado com sucesso :)")

    }
}
