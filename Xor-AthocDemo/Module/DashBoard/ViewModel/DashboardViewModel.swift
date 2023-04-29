//
//  DashboardViewController.swift
//  Xor-AthocDemo
//
//  Created by Sahil Ratnani on 29/04/23.
//

import Foundation

class DashboardViewModel {
    let user: User

    var displayMsg: String {
        "You are registered with \(user.contactTypeEnum?.text ?? "null") - \(user.contact ?? "null")"
    }

    init(user: User) {
        self.user = user
    }
}
