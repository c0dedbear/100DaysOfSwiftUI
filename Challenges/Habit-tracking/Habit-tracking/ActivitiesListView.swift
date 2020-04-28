//
//  ActivitiesListView.swift
//  Habit-tracking
//
//  Created by Михаил Медведев on 26.04.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI


struct ActivitiesListView: View {
	@ObservedObject var list = ActivityList()
	@State private var presentingSheet = false
	@State private var presentingNewSheet = false
	@State private var selectedActivity: Activity?

	var body: some View {
		NavigationView {
			List(list.activities, id: \.id) { activity in
				VStack(alignment: .leading, spacing: 8) {
					Text(activity.title).font(.subheadline)
					Text(activity.description).font(.caption)
				}
				.onTapGesture() {
					self.presentingSheet = true
					self.selectedActivity = activity
				}
				.sheet(isPresented: self.$presentingSheet) {
					FormView(activity: self.selectedActivity!, list: self.list, isNew: false)
				}
				Spacer()
				Image(systemName: activity.completed ? "checkmark.circle.fill" : "circle") .foregroundColor(Color.green)
					.onTapGesture() {
						withAnimation(.default) {
							self.list.activities[activity.id].completed.toggle()
						}
				}
			}
			.navigationBarTitle(Text("Activities 💡"), displayMode: .inline)
			.navigationBarItems(trailing: Button(action: {
				self.presentingNewSheet = true
			}) {
				Image(systemName: "plus.circle") }.accentColor(.green))
				.sheet(isPresented: self.$presentingNewSheet) {
					FormView(activity: Activity(id: self.list.activities.count, title: "", description: ""), list: self.list, isNew: true)
			}
		}
	}

	init() {
		if let activities = ActivityList.load() {
			self.list.activities = activities
		}
	}
}

struct ActivitiesListView_Previews: PreviewProvider {
	static var previews: some View {
		ActivitiesListView()
	}
}
