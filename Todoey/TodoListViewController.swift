//
//  ViewController.swift
//  Todoey
//
//  Created by Dyadichev on 31.03.2022.
//

import UIKit

class TodoListViewController: UIViewController {
    
    //MARK: - Properties
    
    private var contact = ["Vladimir Dyadichev", "Angela U", "Ekaterina Cheremnova"]
    private let todoListIdentifier = "todoListIdentifier"
    
    // Создаем UserDefaults
    private var userDefault = UserDefaults.standard
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.fillerRowHeight = 1.0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Todolist"
        
        // Третий шаг достаем наши данные при запуске приложения которые мы ранее сохранили. 
        if let items = userDefault.array(forKey: "TodoList") as? [String] {
            contact = items
        }
        
        configureBarButtonItem()
        
        setDelegates()
        setConstraints()
        setupViews()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: todoListIdentifier)
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
        
    }
    
    //MARK: - Button
    
    @objc func addButtonClicked(_ sender: UIBarButtonItem){
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Добавить новый контакт",
                                      message: "",
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Добавить",
                                   style: .default) { action in
            
            // Что произойдет когда пользователь добавит кнопку добавить элемент на нашем UIAlert
            self.contact.append(textField.text!)
            // Говорим что мы будем сохранять. В нашем случае массив contact, ключ будет TodoList ( cоздаем произвольное название)
            self.userDefault.set(self.contact, forKey: "TodoList")
            // Нужно обновить нашу таблицу после того как мы добавили в нее новые данные.
            self.tableView.reloadData()
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Введите имя контакта"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Private Function
    
    private func configureBarButtonItem() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonClicked))
    }
    
    private func setupViews() {
        
        view.addSubview(tableView)
    }
    
    private func setDelegates() {
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: - TableViewDataSource, TableViewDelegate

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: todoListIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.secondaryText = contact[indexPath.row]
        content.secondaryTextProperties.font = .systemFont(ofSize: 20)
        cell.contentConfiguration = content
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(contact[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TodoListViewController {
    
    func setConstraints() {
        
        //        NSLayoutConstraint.activate([
        //            sceneView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        //            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        //            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        //            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        //        ])
        //
        //        NSLayoutConstraint.activate([
        //            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        //            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        //            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        //        ])
    }
}
