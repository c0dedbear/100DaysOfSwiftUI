//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Михаил Медведев on 03.06.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
	@Environment(\.presentationMode) var presentationMode
	@Binding var isCardShouldBack: Bool

    var body: some View {
        NavigationView {
            List {
                Section {
					Toggle(isOn: $isCardShouldBack) {
						Text("Put card back on wrong answer")
					}
                }
            }
            .navigationBarTitle("Options")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
            .listStyle(GroupedListStyle())
        }.navigationViewStyle(StackNavigationViewStyle())
    }

    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
