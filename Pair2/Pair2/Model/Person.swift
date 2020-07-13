//
//  Person.swift
//  Pair2
//
//  Created by Kristin Samuels  on 7/13/20.
//  Copyright © 2020 Kristin Samuels . All rights reserved.
//

import Foundation

class Person: Codable {
    var name: String
    
    init (name: String) {
        self.name = name
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.name == rhs.name
    }
}
