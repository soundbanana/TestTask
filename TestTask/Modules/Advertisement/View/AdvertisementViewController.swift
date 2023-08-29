//
//  AdvertisementViewController.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import UIKit

class AdvertisementViewController: UIViewController, AdvertisementViewProtocol {
    var presenter: AdvertisementPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
