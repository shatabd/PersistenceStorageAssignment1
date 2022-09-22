//
//  SecondViewController.swift
//  PersistenceStorageAssignment1
//
//  Created by Macmini-13 on 21/09/2022.
//

import UIKit

//MARK: Procotol and Delegate
protocol  AddListDelegate: NSObject {
    func addlist()
}

class SecondViewController: UIViewController {
    
    enum ViewType {
        case fromAddPlus
        case fromSheet
    }
    
    //MARK: Outlets
    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var addListButton: UIButton!
    
    weak var addDelegate: AddListDelegate?
    var type:ViewType = .fromAddPlus
    var todoItem: ToDoListItem?
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if type == .fromSheet {
            addTextField.text = todoItem?.name
            addListButton.setTitle("Edit", for: .normal)
        } else {
            addListButton.setTitle("Add", for: .normal)
        }
    }
    
    //MARK: IBAction
    @IBAction func addButton(_ sender: Any) {
        if type == .fromAddPlus {
            let newItem = ToDoListItem(context: context)
            newItem.name = addTextField.text
            newItem.createdAt = Date()
            
            do {
                try context.save()
                dismiss(animated: true)
                addDelegate?.addlist()
            }
            catch {
                
            }
        }
        else {
            todoItem?.name = addTextField.text
            
            do {
                try context.save()
                dismiss(animated: true)
                addDelegate?.addlist()
            }
            catch {
                
            }
        }
    }
}


