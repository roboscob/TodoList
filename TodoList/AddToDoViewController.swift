//
//  AddToDoViewController.swift
//  TodoList
//
//  Created by Tyler Hellmann on 3/15/22.
//

import UIKit

class AddToDoViewController: UIViewController {
    var toDoTableViewController: ToDoTableViewController?=nil

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    
    @IBAction func addTapped(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let newToDo = ToDoCD(context: context)
            newToDo.priority = Int32(prioritySegment.selectedSegmentIndex)
            
            if let name = nameTextField.text {
                newToDo.name = name
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
