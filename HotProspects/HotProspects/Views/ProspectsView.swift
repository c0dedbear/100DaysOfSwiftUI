//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Михаил Медведев on 01.06.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import UserNotifications
import CodeScanner
import SwiftUI

struct ProspectsView: View {
	enum FilterType {
		case none, contacted, uncontacted
	}

	enum SortingOrder {
		case name
		case recent
	}

	@EnvironmentObject private var prospects: Prospects
	@State private var isShowingScanner = false

	@State private var sortingOrder = SortingOrder.recent

	var filteredProspects: [Prospect] {
		switch filter {
		case .none:
			return prospects.people
		case .contacted:
			return prospects.people.filter { $0.isContacted }
		case .uncontacted:
			return prospects.people.filter { !$0.isContacted }
		}
	}

	let filter: FilterType

	var title: String {
		switch filter {
		case .none:
			return "Everyone"
		case .contacted:
			return "Contacted people"
		case .uncontacted:
			return "Uncontacted people"
		}
	}

    var body: some View {
      NavigationView {
			List {
				ForEach(filteredProspects) { prospect in
					HStack {
					VStack(alignment: .leading) {
						Text(prospect.name)
							.font(.headline)
						Text(prospect.emailAddress)
							.foregroundColor(.secondary)
						}
						if prospect.isContacted {
						Spacer()
						Image(systemName: "person.crop.circle.badge.checkmark")
						}
					}.contextMenu {
						Button(action: { self.prospects.toggle(prospect)}) {
							Text(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted")
							Image(systemName: prospect.isContacted ? "person.crop.circle.badge.minus" : "person.crop.circle.badge.checkmark")

						}
						if !prospect.isContacted {
							Button(action: { self.addNotification(for: prospect) }) {
								Text("Remind Me")
								Image(systemName: "bell")

							}
						}

						if self.sortingOrder == .name {
							Button("Sort by recents 🕐" ) {
								self.prospects.sort { $0.date < $1.date }
								self.sortingOrder = .recent
							}
						}

						if self.sortingOrder == .recent {
							Button("Sort by name 💱" ) {
								self.prospects.sort { $0.name.caseInsensitiveCompare($1.name) == .orderedAscending }
								self.sortingOrder = .name
							}
						}
					}
				}
			}.sheet(isPresented: $isShowingScanner) {
				CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: self.handleScan)
			}
				.navigationBarTitle(title)
				.navigationBarItems(trailing: Button(action: {
					self.isShowingScanner = true
				}) {
					Image(systemName: "qrcode.viewfinder")
					Text("Scan")
				})
		}
    }

	private func handleScan(result: Result<String, CodeScannerView.ScanError>) {
	   self.isShowingScanner = false
	  switch result {
	   case .success(let code):
		   let details = code.components(separatedBy: "\n")
		   guard details.count == 2 else { return }

		   let person = Prospect()
		   person.name = details[0]
		   person.emailAddress = details[1]

		   self.prospects.add(person)
	   case .failure(let error):
		   print("Scanning failed")
	   }
	}

	private func addNotification(for prospect: Prospect) {
		let center = UNUserNotificationCenter.current()

		let addRequest = {
			let content = UNMutableNotificationContent()
			content.title = "Contact \(prospect.name)"
			content.subtitle = prospect.emailAddress
			content.sound = UNNotificationSound.default

//			var dateComponents = DateComponents()
//			dateComponents.hour = 9
//			let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

			// for testing
			let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

			let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
			center.add(request)
		}

		center.getNotificationSettings { settings in
			if settings.authorizationStatus == .authorized {
				addRequest()
			} else {
				center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
					if success {
						addRequest()
					} else {
						print("D'oh")
					}
				}
			}
		}
	}
}

struct ProspectView_Previews: PreviewProvider {
    static var previews: some View {
		ProspectsView(filter: .contacted)
    }
}
