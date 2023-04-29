//
//  ContactType.swift
//  Xor-AthocDemo
//
//  Created by Sahil Ratnani on 29/04/23.
//

enum ContactType: Int, CaseIterable {
    case phone = 1
    case email = 2

    var text: String {
        switch self {
        case .phone:
            return "Phone No"
        case .email:
            return "Email"
        }
    }
}
