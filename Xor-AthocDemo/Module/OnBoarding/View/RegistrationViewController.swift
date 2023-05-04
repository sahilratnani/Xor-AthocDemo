//
//  RegistrationViewController.swift
//  Xor-AthocDemo
//
//  Created by Sahil Ratnani on 28/04/23.
//

import UIKit
class RegistrationViewController: UIViewController {

    @IBOutlet weak var registrationOptionsMenuBtn: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    var viewModel: RegistrationViewModel? = RegistrationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenu()
        setupTextField()
    }

    func setupTextField() {
        textField.delegate = self
        textField.placeholder = viewModel?.selectedOption.text
        
        errorLabel.isHidden = true
    }

    func setupMenu() {
        guard let viewModel = viewModel else  {
            assertionFailure("Could not load view model - \(Self.description())")
            return
        }
        var options: [UIAction] = []
        for option in viewModel.registrationOptions {
            let item = UIAction(title: option.text, handler: { [weak self] _ in
                guard let index = viewModel.registrationOptions.firstIndex(of: option) else { return }
                self?.didSelectRegistrationOption(at: index)
            })
            if option == viewModel.selectedOption {
                item.state = .on
                setRegistrationOptnBtnTitle(selectedOption: option)
                setupKeyBoardFor(type: option)
            }
            options.append(item)
        }
        let menu = UIMenu(title: "", options: [.singleSelection], children: options)
        registrationOptionsMenuBtn.menu = menu
        registrationOptionsMenuBtn.showsMenuAsPrimaryAction = true
    }

    func setupKeyBoardFor(type: ContactType) {
        textField.keyboardType = type == .phone ? .numberPad : .default
        textField.reloadInputViews()
    }

    func didSelectRegistrationOption(at index: Int) {
        guard let selectedOption = viewModel?.registrationOptions[index] else { return }
        viewModel?.selectRegistrationOption(selectedOption)
        setRegistrationOptnBtnTitle(selectedOption: selectedOption)
        setupTextField()
        setupKeyBoardFor(type: selectedOption)
        if textField.text?.isEmpty == false {
            validateTextField()
        }
    }

    func setRegistrationOptnBtnTitle(selectedOption: ContactType) {
        registrationOptionsMenuBtn.setTitle(selectedOption.text, for: .normal)
    }

    @IBAction func submitButtonDidTap(_ sender: UIButton) {
        view.endEditing(true)
        guard let user = viewModel?.prepareForSubmission() else { return }
        ADNavigator.navigateTo(screen: .verificationScreen, data: ["user" : user])
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Validate user input
        validateTextField()
    }

    ///Validate user input and update view model
    func validateTextField() {
        let error = viewModel?.validateTextField(string: textField.text)
        errorLabel.isHidden = error == nil
        errorLabel.text = error
    }
}
