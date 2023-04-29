//
//  RegistrationViewModel.swift
//  Xor-AthocDemo
//
//  Created by Sahil Ratnani on 27/04/23.
//

import Foundation

class RegistrationViewModel {
    let registrationOptions =  ContactType.allCases
    private(set) var selectedOption: ContactType = .phone {
        didSet {
        }
    }
    private(set) var contact: String?

    var isFormValid: Bool {
        contact?.isEmpty == false
    }

    func selectRegistrationOption(_ option: ContactType) {
        selectedOption = option
    }

    func validateTextField(string: String?) -> String? {
        let rules: [Rule]
        switch selectedOption {
        case .phone:
            rules = [.notEmpty, .validPhoneNo]

        case .email:
            rules = [.notEmpty, .validEmail]
        }
        let error = ADValidator.validate(text: string ?? "", with: rules)
        if error == nil {
            //Store the valid data
           contact = string
        } else {
            contact = nil
        }
        return error
    }

    func prepareForSubmission() -> User? {
        guard isFormValid else {
            return nil
        }
        let user = ADDataStore.createUser(contactType: selectedOption.rawValue, contact: contact)
        return user
    }
}
