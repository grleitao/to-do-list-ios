import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .darkGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .darkGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.tintColor = .darkGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Properties
    var deleteButtonAction: (() -> Void)?
    var editButtonAction: (() -> Void)?
    var checkButtonAction: (() -> Void)?
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupShadow()
        setupButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupShadow() {
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowRadius = 4
        containerView.layer.masksToBounds = false
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(editButton)
        containerView.addSubview(deleteButton)
        containerView.addSubview(checkButton)
        
        NSLayoutConstraint.activate([
            // Container View
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            
            // Subtitle Label
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            
            // Date Label
            dateLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            // Edit Button
            editButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            editButton.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -15),
            editButton.widthAnchor.constraint(equalToConstant: 24),
            editButton.heightAnchor.constraint(equalToConstant: 24),
            
            // Delete Button
            deleteButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: checkButton.leadingAnchor, constant: -15),
            deleteButton.widthAnchor.constraint(equalToConstant: 24),
            deleteButton.heightAnchor.constraint(equalToConstant: 24),
            
            // Check Button
            checkButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            checkButton.widthAnchor.constraint(equalToConstant: 24),
            checkButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupButtonActions() {
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Configure Cell
    func configure(title: String, subtitle: String, date: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        dateLabel.text = date
    }
    
    // MARK: - Button Actions
    @objc private func deleteButtonTapped() {
        deleteButtonAction?()
    }
    
    @objc private func editButtonTapped() {
        editButtonAction?()
    }
    
    @objc private func checkButtonTapped() {
        checkButtonAction?()
    }
}
