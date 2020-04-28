//
//  DetailView.swift
//  Habit-tracking
//
//  Created by Михаил Медведев on 26.04.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI

struct FormView: View {
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject private var list: ActivityList
	@State private var activity: Activity
	private let isNew: Bool

	var body: some View {
		VStack {
		Form {
			Section {
				TextField("Title", text: $activity.title).textFieldStyle(DefaultTextFieldStyle())
					.font(.largeTitle)
				TextField("Note", text: $activity.description).textFieldStyle(DefaultTextFieldStyle())
			}
			Section {
				Toggle(isOn: $activity.completed) { Text("Completed") }
			}
		}
			Button("Save") {
				if self.isNew {
					self.list.activities.append(self.activity)
				} else {
					self.list.activities[self.activity.id] = self.activity
				}
				self.list.save()
				self.presentationMode.wrappedValue.dismiss()
			}
		}
	}

	init(activity: Activity, list: ActivityList, isNew: Bool) {
		_activity = State(initialValue: activity)
		self.list = list
		self.isNew = isNew
	}
}

struct FormView_Previews: PreviewProvider {
	static var previews: some View {
		FormView(activity: ActivityList().activities[0], list: ActivityList(), isNew: false)
	}
}





