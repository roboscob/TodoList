//
//  ToDoTableViewController.swift
//  TodoList
//
//  Created by Tyler Hellmann on 3/15/22.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    //var toDos: [ToDo] = []
    var toDoCDs = [ToDoCD]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return toDos.count
        return toDoCDs.count
    }

    override func viewWillAppear(_ animated: Bool) {
        getToDos()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //let selectedToDo = toDos[indexPath.row]
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
        //let selectedToDo = toDos[indexPath.row]
        let selectedToDo = toDoCDs[indexPath.row]
        performSegue(withIdentifier: "moveToDetails", sender: selectedToDo)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
