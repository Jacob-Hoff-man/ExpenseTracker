//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Jacob on 10/21/20.
//  Copyright © 2020 Jacob. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddItemView = false
    
    
    var body: some View {
        
        VStack {
            //Expenses List!
            NavigationView {
                VStack {
                    List {
                        //no id: needed beacuse expenses.items is Identifiable
                        ForEach(expenses.items) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text("$\(item.amount, specifier: "%.2f")")
                                    .foregroundColor((item.color == amountColor.green ? Color.green : (item.color == amountColor.yellow ? Color.yellow : Color.red)))
                            }
                            
                        }
                        .onDelete(perform: removeItems)
                        
                    }
                    .navigationBarTitle("ExpenseTracker")
                    .navigationBarItems(leading: EditButton(),
                                        trailing:
                        //button
                        Button(action: {
                            //let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                            //self.expenses.items.append(expense)
                            self.showingAddItemView = true
                        }) {
                            Image(systemName: "plus")
                        }
                    )
                        .sheet(isPresented: $showingAddItemView) {
                            AddItemView(expenses: self.expenses)
                    }
                    
                    HStack {
                        Text("Total: ")
                            .font(.largeTitle)
                        
                        Spacer()
                        
                        Text("$\(self.expenses.sum, specifier: "%.2f")")
                            .font(.largeTitle)
                    }
                    .padding()
                }
            }
            
        }
    }
    
    //method capable of deleting an IndexSet of list items,
    //it then passes that directly to our expenses array
    //used in onDelete()
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
