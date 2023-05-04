//
//  VerificationViewModel.swift
//  Xor-AthocDemo
//
//  Created by Sahil Ratnani on 28/04/23.
//

import Foundation

class VerificationViewModel {
    let user: User
    weak var delegate: VerificationViewControllerDelegate?
    var confirmationSentMsg: String {
        "Thank you for registering. We have sent a confirmation to \(user.contact ?? "NA")"
    }

    init(user: User) {
        self.user = user
    }

    func verifyUserInput() {
        ADAPIService.verifyUserDetails(user: user) { [weak self] result in
            guard let self = self else { return }
            if case .success(_) = result {
                ADDataStore.save()
            }
            self.delegate?.handleResponse(result: result)
        }
    }
}
