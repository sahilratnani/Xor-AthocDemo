//
//  VerificationViewController.swift
//  Xor-AthocDemo
//
//  Created by Sahil Ratnani on 27/04/23.
//

import UIKit


protocol VerificationViewControllerDelegate {
    func handleResponse(result: Result<Any, Error>)
}

class VerificationViewController: UIViewController {
    var viewModel: VerificationViewModel?

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        setup()
        viewModel?.verifyUserInput()
        activityIndicator.startAnimating()
    }

    func setup() {
        messageLabel.text = viewModel?.confirmationSentMsg
    }
}

extension VerificationViewController: VerificationViewControllerDelegate {
    func handleResponse(result: Result<Any, Error>) {
        activityIndicator.stopAnimating()
        if case .success(let user) = result {
            ADNavigator.navigateTo(screen: .dashboard, data: ["user": user])
        } else if case .failure(let error) = result {
            ADUtils.displayAlert(title: "Error", message: error.localizedDescription) {
                ADNavigator.navigateBack()
            }
        }
    }
}

