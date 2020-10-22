//
//  Expenses.swift
//  ExpenseTracker
//
//  Created by Jacob on 10/22/20.
//  Copyright © 2020 Jacob. All rights reserved.
//

import Foundation

class Expenses: ObservableObject {
    //to be honest, i thought this would need to be marked as @Published to work, but nope?
    var sum: Double {
        var total = 0.0
        for item in items {
            total += item.amount
        }
        return total
    }
    
    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
        
    }
    
}
