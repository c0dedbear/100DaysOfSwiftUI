//
//  AddView.swift
//  iExpense
//
//  Created by Mikhail Medvedev on 01.11.2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct AddView: View {
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var expenses: Expenses
	@State private var name = ""
	@State private var type = ""
	@State private var amount = ""
	@State private var showAlert = false

	static let types = ["Personal", "Business"]

    var body: some View {
		NavigationView {
			Form {
				Picker("", selection: $type) {
					ForEach(Self.types, id: \.self) {
						Text($0)
					}
				}.pickerStyle(SegmentedPickerStyle())
				TextField("Name", text: $name)
				TextField("Amount", text: $amount).keyboardType(.numberPad)
			}
			.navigationBarTitle("Add new expense")
			.navigationBarItems(trailing:
				Button("Save") {
					if let amount = Int(self.amount) {
						let item = ExpenseItem(id: UUID(), name: self.name, type: self.type, amount: amount)
						self.expenses.items.append(item)
					} else {
					  self.showAlert.toggle()
					  return
					}
					self.presentationMode.wrappedValue.dismiss()
				}
			)
				.alert(isPresented: $showAlert) {
					Alert(title: Text("Error"), message: Text("Only numbers allowed in amount"), dismissButton: .default(Text("OK")))
			}
		}
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
		AddView(expenses: Expenses())
    }
}
