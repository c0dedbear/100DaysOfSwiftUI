//
//  ContentView.swift
//  Project10-CupcakeCorner
//
//  Created by Михаил Медведев on 30.04.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var order = Order()
	private var navigationBarTitle = "Cupcake Corner 🧁"

	var body: some View {
		NavigationView {
			Form {
				Section {
					Picker("Select your cake type", selection: $order.type) {
						ForEach(0..<Order.types.count, id: \.self) {
							Text(Order.types[$0])
						}
					})

					Stepper(value: $order.quantity, in: 3...20) {
						Text("Number of cakes: \(order.quantity)")
					}

					Text(order.emojisQuantity)
				}

				Section {
					Toggle(isOn: $order.specialRequestEnabled.animation()) {
						Text("Any special requests?")
					}

					if order.specialRequestEnabled {
						Toggle(isOn: $order.extraFrosting) {
							Text("Add extra frosting")
						}

						Toggle(isOn: $order.addSprinkles) {
							Text("Add extra sprinkles")
						}
					}
				}

				Section {
					NavigationLink(destination: AddressView(order: order)) {
						Text("Delivery details")
					}
				}
			}
			.navigationBarTitle(navigationBarTitle)
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
