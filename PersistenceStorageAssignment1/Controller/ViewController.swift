//
//  ViewController.swift
//  PersistenceStorageAssignment1
//
//  Created by Macmini-13 on 21/09/2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var models = [ToDoListItem] ()
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ToDo List"
        
        tableView.delegate = self
        tableView.dataSource = self
        getAllItems()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
  
    @objc private func didTapAdd() {
        let stordboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = stordboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        controller.addDelegate = self
        
        present(controller, animated: true)
    }
    
    
    //MARK:  Core Data
    func getAllItems() {
        do {
            models = try context.fetch(ToDoListItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch (let err){
            print(err.localizedDescription)
        }
    }
    
    
    func deleteItem(item: ToDoListItem) {
        context.delete(item)
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
}
//MARK: - Methods
extension ViewController: AddListDelegate{
    func addlist() {
        getAllItems()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.nameLabel.text = models[indexPath.row].name
        cell.dateLabel.text = models[indexPath.row].createdAt!.dateToString()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
        let stordboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = stordboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        controller.addDelegate = self
        controller.todoItem = self.models[indexPath.row]
        controller.type = .fromSheet
        
        self.present(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARKS: Delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = models[indexPath.row]
        
        if editingStyle == .delete{
            self.deleteItem(item: item)
        }
    }
}
