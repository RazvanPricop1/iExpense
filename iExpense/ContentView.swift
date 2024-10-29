//
//  ContentView.swift
//  iExpense
//
//  Created by Razvan Pricop on 21.10.24.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var filter = ""
    
    var body: some View {
        NavigationStack {
            HStack {
                Button("All") {
                    filter = ""
                }
                Button("Personal") {
                    filter = "Business"
                }
                Button("Business") {
                    filter = "Personal"
                }
            }
            List {
                ForEach(expenses.items) { item in
                    if (item.type != filter) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: UserDefaults.standard.string(forKey: "currency") ?? "EUR"))
                                .foregroundStyle(item.amount < 10 ? .green : (item.amount < 100 ? .blue : .red))
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Expenses")
            .toolbar {
                NavigationLink {
                    AddView(expenses: expenses)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
