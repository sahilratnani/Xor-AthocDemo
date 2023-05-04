//
//  RegistrationViewModel.swift
//  Xor-AthocDemo
//
//  Created by Sahil Ratnani on 27/04/23.
//

import Foundation

///View Model for `RegistrationViewController`
class RegistrationViewModel {
    let registrationOptions =  ContactType.allCases
    private(set) var selectedOption: ContactType = .phone {
        didSet {
        }
    }
    private(set) var contact: String?

    ///Returns form state based on fields validation state
    var isFormValid: Bool {
        contact?.isEmpty == false
    }

    ///Update selected option for registration
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

    ///Prepare `User` managed object with users input data for verification
    func prepareForSubmission() -> User? {
        guard isFormValid else {
            return nil
        }
        let user = ADDataStore.createUser(contactType: selectedOption.rawValue, contact: contact)
        return user
    }
}
