//
//  PlaceholderViewController.swift
//  MVVMC-SplitViewController
//
//  Created by Mathew Gacy on 1/8/18.
//  Copyright © 2018 Mathew Gacy. All rights reserved.
//

import UIKit
import ColorCompatibility

class PlaceholderViewController: UIViewController, PlaceholderViewControllerType {

    let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "EmptyViewBackground")
        view.tintColor = ColorCompatibility.systemGray2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        if let displayModeButtonItem = splitViewController?.displayModeButtonItem {
            navigationItem.leftBarButtonItem = displayModeButtonItem
        }
    }

    // MARK: - View Methods

    func setupView() {
        view.backgroundColor = ColorCompatibility.systemBackground
        self.view.addSubview(backgroundImageView)
        navigationItem.leftItemsSupplementBackButton = true
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.widthAnchor.constraint(equalToConstant: 180.0),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 180.0),
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}
