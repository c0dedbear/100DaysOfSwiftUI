//
//  ContentView.swift
//  iExpense
//
//  Created by Mikhail Medvedev on 31.10.2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable
{
	let id: UUID
	let name: String
	let type: String
	let amount: Int
}

final class Expenses: ObservableObject
{
	@Published var items = [ExpenseItem]() {
		didSet {
			let encoder = JSONEncoder()
			if let data = try? encoder.encode(items) {
				UserDefaults.standard.setValue(data, forKey: "Items")
			}
		}
	}
	
	init() {
		let decoder = JSONDecoder()
		
		if let data = UserDefaults.standard.data(forKey: "Items") {
			if let items = try? decoder.decode([ExpenseItem].self, from: data) {
				self.items = items
				return
			}
		}
		
		self.items = []
	}
}

struct ContentView: View
{
	@ObservedObject var expenses = Expenses()
	@State private var showingAddExpenseView = false
	var body: some View {
		NavigationView {
			List {
				ForEach(expenses.items) { item in
					HStack {
						VStack(alignment: .leading) {
							Text(item.name).font(.headline)
							Text(item.type).font(.subheadline)
						}
						Spacer()
						Text("$\(item.amount)").foregroundColor(self.highlight(item.amount))
					}
					
				}.onDelete(perform: removeItems)
			}
			.navigationBarItems(leading: EditButton(), trailing:
				Button(action: {
					self.showingAddExpenseView.toggle()
				}) {
					Image(systemName: "plus")
				}
			)
				.navigationBarTitle("iExpense")
		}.sheet(isPresented: $showingAddExpenseView) {
			AddView(expenses: self.expenses)
		}
	}
	
	func removeItems(at offsets: IndexSet) {
		expenses.items.remove(atOffsets: offsets)
	}
	
	func highlight(_ amount: Int) -> Color {
		switch amount {
		case 0...10: return .green
		case 11...100: return .yellow
		case 100...: return .orange
		default: return .accentColor
		}
	}
}

struct ContentView_Previews: PreviewProvider
{
	static var previews: some View {
		ContentView()
	}
}
