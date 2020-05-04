//
//  AddressView.swift
//  Project10-CupcakeCorner
//
//  Created by Михаил Медведев on 01.05.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI

struct AddressView: View {
	@ObservedObject var order: Order

	private var showTip: Bool {
		let isEmpty = order.name.isEmpty || order.streetAddress.isEmpty || order.city.isEmpty || order.zip.isEmpty
		if isEmpty == false && order.hasValidAddress == false {
			return true
		}
		 return false
	}

	var body: some View {
		Form {
			Section(footer: Text( showTip ? "Please, input correct address" : "").font(.footnote).foregroundColor(.red).frame(maxWidth: UIScreen.main.bounds.width, alignment: .center)) {
				TextField("Name", text: $order.name)
				TextField("Street Address", text: $order.streetAddress)
				TextField("City", text: $order.city)
				TextField("Zip", text: $order.zip)
			}

			Section {
				NavigationLink(destination: CheckoutView(order: order)) {
					Text("Check out")
				}
			}.disabled(order.hasValidAddress == false)
		}
		.navigationBarTitle("Delivery details", displayMode: .inline)
	}
}

struct AddressView_Previews: PreviewProvider {
	static var previews: some View {
		AddressView(order: Order())
	}
}
