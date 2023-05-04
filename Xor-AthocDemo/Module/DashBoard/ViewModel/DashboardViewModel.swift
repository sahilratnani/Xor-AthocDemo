//
//  DashboardViewController.swift
//  Xor-AthocDemo
//
//  Created by Sahil Ratnani on 29/04/23.
//

import Foundation

///View Model for `DashboardViewController`
class DashboardViewModel {
    let user: User

    ///Welcome screen message with registration information.
    var displayMsg: String {
        "You are registered with \(user.contactTypeEnum?.text ?? "null") - \(user.contact ?? "null")"
    }

    init(user: User) {
        self.user = user
    }
}
