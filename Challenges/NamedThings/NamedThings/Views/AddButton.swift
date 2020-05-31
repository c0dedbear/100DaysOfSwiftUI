//
//  AddButton.swift
//  NamedThings
//
//  Created by Михаил Медведев on 30.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct AddButton: View {
	private let action: () -> Void

	var body: some View {
		VStack {
			Spacer()
			HStack {
				Spacer()
				Button(action: self.action) {
					Image(systemName: "plus")
						.font(.title)
				}
				.padding(20)
				.foregroundColor(Color.white)
				.background(Color.orange)
				.cornerRadius(.infinity)
			}
			.padding(.trailing, 30)
			.padding(.bottom, 20)
			.shadow(radius: 4)
		}
	}

	init(action: @escaping () -> Void) {
		self.action = action
	}
}

struct AddButton_Previews: PreviewProvider {
	static var previews: some View {
		AddButton(action: {})
	}
}
