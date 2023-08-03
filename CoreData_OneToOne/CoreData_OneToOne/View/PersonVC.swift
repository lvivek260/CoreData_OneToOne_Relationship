//
//  ViewController.swift
//  CoreData_OneToOne
//
//  Created by PHN MAC 1 on 31/07/23.
//

import UIKit

class PersonVC: UIViewController {
    
// MARK: - IBOutlets
    @IBOutlet weak var personTableView: UITableView!
    var persons = [PersonEntity]()
    
// MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
// MARK: - IBActions
    @IBAction func addPersonBtnClick(_ sender: Any) {
        guard let addPersonVC = storyboard?.instantiateViewController(withIdentifier: "AddUpdatePersonVC") as? AddUpdatePersonVC else{
            return
        }
        navigationController?.pushViewController(addPersonVC, animated: true)
    }
}

// MARK: - Methods
extension PersonVC{
    private func fetchData(){
        persons = CoreDataManager.shared.fetchPerson()
        personTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource Methods
extension PersonVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = personTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        let person = persons[indexPath.row]
        configuration.text = (person.firstName ?? "") + " " + (person.lastName ?? "")
        configuration.secondaryText = "Age: " + String(person.age)
      //  configuration.image = UIImage(systemName: "person.circle.fill")!
        cell.contentConfiguration = configuration
        return cell
    }
}

// MARK: - UITableViewDelegate Methods
extension PersonVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailPerson = storyboard?.instantiateViewController(withIdentifier: "DetailPersonVC") as? DetailPersonVC else{
            return
        }
        detailPerson.personEntity = persons[indexPath.row]
        navigationController?.pushViewController(detailPerson, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete", handler: {_,_,_ in
            CoreDataManager.shared.deletePerson(personEntity: self.persons[indexPath.row])
            self.persons.remove(at: indexPath.row)
            self.personTableView.reloadData()
        })
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

