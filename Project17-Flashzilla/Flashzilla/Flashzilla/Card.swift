//
//  Card.swift
//  Flashzilla
//
//  Created by Михаил Медведев on 02.06.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

struct Card: Codable {
    let prompt: String
    let answer: String

    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
