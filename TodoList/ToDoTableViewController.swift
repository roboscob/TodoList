//
//  ToDoTableViewController.swift
//  TodoList
//
//  Created by Tyler Hellmann on 3/15/22.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    var toDoCDs = [ToDoCD]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func getToDos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let toDosFromCoreData = try? context.fetch(ToDoCD.fetchRequest()) {
                if let toDos = toDosFromCoreData as? [ToDoCD] {
                    toDoCDs = toDos
                    tableView.reloadData()
                }
            }
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoCDs.count
    }

    override func viewWillAppear(_ animated: Bool) {
        getToDos()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let selectedToDo = toDoCDs[indexPath.row]
        
        if (selectedToDo.priority == 1) {
            if let name = selectedToDo.name {
                cell.textLabel?.text = "❗️" + name
            }
        }
        else if (selectedToDo.priority == 2) {
            if let name = selectedToDo.name {
                cell.textLabel?.text = "‼️" + name
            }
        }
        else {
            if let name = selectedToDo.name {
                cell.textLabel?.text = name
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedToDo = toDoCDs[indexPath.row]
        performSegue(withIdentifier: "moveToDetails", sender: selectedToDo)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addToDoViewController = segue.destination as? AddToDoViewController {
            addToDoViewController.toDoTableViewController = self
        }
        
        if let detailsToDoViewController = segue.destination as? ToDoDetailsViewController {
            if let selectedToDo = sender as? ToDoCD {
                detailsToDoViewController.toDoCD = selectedToDo
            }
        }
    }
}
