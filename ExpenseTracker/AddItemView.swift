//
//  AddItemView.swift
//  ExpenseTracker
//
//  Created by Jacob on 10/22/20.
//  Copyright © 2020 Jacob. All rights reserved.
//

import SwiftUI

struct AddItemView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var showAmountAlert = false
    @ObservedObject var expenses: Expenses
    
    @Environment(\.presentationMode) var presentationMode
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(UIKeyboardType.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Double(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showAmountAlert = true
                }
            })
                .alert(isPresented: $showAmountAlert) {
                    Alert(title: Text("Enter a valid amount!"),
                          message: Text("The value entered in amount must be a real number."),
                          dismissButton: .default(Text("Continue")) {
                            self.showAmountAlert = false
                    })
            }
        }
    }
    
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(expenses: Expenses())
    }
}
