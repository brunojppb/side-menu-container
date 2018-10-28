//
//  MenuViewController.swift
//  sidemenutest
//
//  Created by Bruno Paulino on 28.10.18.
//  Copyright © 2018 bpaulino. All rights reserved.
//

import UIKit

class MenuViewController: UINavigationController {
  
  let optionsController = OptionsViewController()
  
  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
    let menuButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onMenuSelect))
    rootViewController.navigationItem.leftBarButtonItem = menuButton
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  private func setupUI() {
    addChild(optionsController)
    view.addSubview(optionsController.view)
    optionsController.view.translatesAutoresizingMaskIntoConstraints = false
    optionsController.didMove(toParent: self)
  }
  
  @objc func onMenuSelect() {
    print("Menu selected")
    optionsController.toggleMenu()
  }
  
}
