//
//  DashboardViewController.swift
//  Xor-AthocDemo
//
//  Created by Sahil Ratnani on 29/04/23.
//

import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet weak var messageLabel: UILabel!

    var viewModel: DashboardViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        messageLabel.text = viewModel?.displayMsg
    }

    override func viewWillAppear(_ animated: Bool) {
        //Hide bar as Dashboard becomes the parent view of navigation flow after login.
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
