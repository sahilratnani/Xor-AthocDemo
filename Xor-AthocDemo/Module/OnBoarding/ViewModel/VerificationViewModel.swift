//
//  VerificationViewModel.swift
//  Xor-AthocDemo
//
//  Created by Sahil Ratnani on 28/04/23.
//

import Foundation

class VerificationViewModel {
    let user: User
    var delegate: VerificationViewControllerDelegate?

    init(user: User) {
        self.user = user
    }

    func verifyUserInput() {
        ADAPIService.verifyUserDetails(user: user) { [weak self] result in
            if case .success(_) = result {
                ADDataStore.save()
            }
            self?.delegate?.handleResponse(result: result)
        }
    }
}
