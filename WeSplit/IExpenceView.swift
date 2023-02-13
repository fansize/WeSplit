//
//  IExpenceView.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/12.
//

import SwiftUI

struct IExpenceView: View {
    @StateObject private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    
    var body: some View {
        NavigationStack {
            VStack() {
                List {
                    ForEach(expenses.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: "USD"))
                        }
                    }
                    .onDelete(perform: removeRow)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddExpenceView(expenses: expenses)
            }
        }
    }
    
    func removeRow(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

struct IExpenceView_Previews: PreviewProvider {
    static var previews: some View {
        IExpenceView()
    }
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "items") {
            if let decodedItem = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItem
                return
            }
        }
        items = []
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
