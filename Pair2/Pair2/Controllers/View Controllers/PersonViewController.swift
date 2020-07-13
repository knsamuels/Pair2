//
//  PersonViewController.swift
//  Pair2
//
//  Created by Kristin Samuels  on 7/13/20.
//  Copyright © 2020 Kristin Samuels . All rights reserved.
//

import UIKit

class PersonViewController: UIViewController {
    

    @IBOutlet weak var pairTableView: UITableView!
    
    var personLandingPad: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        PersonController.shared.loadFromPersistenceStore()
    }
    // Mark: Actions
    
    @IBAction func plusButtonTapped(_ sender: Any)  {
        let alert = UIAlertController(title: "Add Person", message: "Please new person's name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Name"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
            guard let newName = alert.textFields?[0].text else {return}
            PersonController.shared.createPerson(name: newName)
            self.pairTableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelButton)
        alert.addAction(saveAction)
        self.present(alert,animated: true)
    }
    
    @IBAction func randomizeButtonTapped(_ sender: Any) {
        PersonController.shared.groupOfPeople.removeAll { person in
            return person.name == "empty"
        }
        PersonController.shared.groupOfPeople.shuffle()
        pairTableView.reloadData()
    }
    
    // Mark: class methods
    func configureTableView() {
        pairTableView.delegate = self
        pairTableView.dataSource = self
    }
}

extension PersonViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        let double = (Double(PersonController.shared.groupOfPeople.count) / 2.0)
        return Int(double.rounded(.up))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if PersonController.shared.groupOfPeople.count / 2 > section {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        let actualIndex = indexPath.section * 2 + indexPath.row
        let person = PersonController.shared.groupOfPeople[actualIndex]
        if person.name != "empty" {
            cell.textLabel?.text = person.name
        } else {
            cell.textLabel?.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = 2 * indexPath.section + 1 * indexPath.row
            let personToDelete = PersonController.shared.groupOfPeople[index]
            personToDelete.name = "empty"
            tableView.reloadData()
        }
    }
}


