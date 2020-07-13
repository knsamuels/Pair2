//
//  PersonController.swift
//  Pair2
//
//  Created by Kristin Samuels  on 7/13/20.
//  Copyright © 2020 Kristin Samuels . All rights reserved.
//

import Foundation

class PersonController {
   
    static let shared = PersonController()
    
    var groupOfPeople: [Person] = []
    
    //Mark: CRUD
    
    func createPerson(name: String) {
        let newPerson = Person(name: name)
        groupOfPeople.append(newPerson)
        saveToPersistenceStore()
    }
    
    func updatePerson(person: Person, name: String) {
        person.name = name
        saveToPersistenceStore()
    }
    
    func deletePerson(person: Person) {
        guard let index = groupOfPeople.firstIndex(of: person) else {return}
        groupOfPeople.remove(at: index)
        saveToPersistenceStore()
    }
    // MARK: Persistence
  
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Pair2.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(groupOfPeople)
           try data.write(to: createPersistenceStore())
        } catch {
            print("there was an error encoding the data: \(error) -- \(error.localizedDescription)")
        }
    }

    func loadFromPersistenceStore() {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            groupOfPeople = try jsonDecoder.decode([Person].self, from: data)
        } catch {
            print("there was an error encoding the data: \(error) -- \(error.localizedDescription)")
        }
    }
}

