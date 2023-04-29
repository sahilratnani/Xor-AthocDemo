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
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
