//
//  Dices_VIew.swift
//  RollDice
//
//  Created by Михаил Медведев on 06.06.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI

struct Dices_View: View {
	// change to CoreData
	@EnvironmentObject private var history: RollsHistory
	@State var feedback = UINotificationFeedbackGenerator()

	@Binding var dicesCount: Int
	@State var firstValue = DiceValue.allCases.randomElement()!
	@State var secondValue = DiceValue.allCases.randomElement()!

	@State var sumText = ""
	@State var dicesWasRolled = false

	private var summary: Int { firstValue.rawValue + secondValue.rawValue }

	var body: some View {
       return ZStack {
            Color(red: 0, green: 153/255, blue: 0)
                .edgesIgnoringSafeArea(.all)
            VStack {
				Spacer()
				Text(dicesWasRolled ? "Rolled: " + sumText : "Roll dices")
                    .font(.system(size: 60))
                    .bold()
                    .fontWeight(.heavy)

                Spacer()

                VStack {
					if dicesWasRolled {
					DiceView(value: $firstValue)
					DiceView(value: $secondValue)
					}
				}

                Spacer()

				Button(action: {
					self.rollDice()
                }) {
                    Text("Roll")
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                        .padding(.horizontal)

                }
            }

		}
		.transition(.opacity)
    }


	private func rollDice() {
		withAnimation {
		self.firstValue = DiceValue.allCases.randomElement()!
		self.secondValue = DiceValue.allCases.randomElement()!
		dicesWasRolled = true
		}
		sumText = "\(firstValue.rawValue + secondValue.rawValue)"
		self.history.addRoll(RolledDice(sum: self.summary, date: Date()))
		self.feedback.notificationOccurred(.success)
	}
}

struct Dices_VIew_Previews: PreviewProvider {
    static var previews: some View {
		Dices_View(dicesCount: .constant(2))
    }
}
