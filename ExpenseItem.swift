//
//  ExpenseItem.swift
//  ExpenseTracker
//
//  Created by Jacob on 10/22/20.
//  Copyright © 2020 Jacob. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()    //universally unique identifier generated
    let name: String
    let type: String
    let amount: Double
    var color: amountColor {
        if amount >= 10 && amount < 100 {
            return .yellow
        } else if amount >= 100 {
            return .red
        }
        return .green
    }
}

enum amountColor {
    case green
    case yellow
    case red
}
