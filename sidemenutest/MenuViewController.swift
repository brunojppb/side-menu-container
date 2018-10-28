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
  let menuControllers: [UIViewController] = [
    ViewController(text: "menu 1", color: .red),
    ViewController(text: "menu 2", color: .blue),
    ViewController(text: "menu 3", color: .darkGray),
    ViewController(text: "menu 4", color: .green),
    ViewController(text: "menu 5", color: .purple)
  ]
  
  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
    setMenuButtonToRootViewController(rootViewController)
    optionsController.delegate = self
  }
  
  private func setMenuButtonToRootViewController(_ rootController: UIViewController) {
    let menuButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onMenuSelect))
    rootController.navigationItem.leftBarButtonItem = menuButton
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

extension MenuViewController: OptionsViewControllerDelegate {
  func didSelectMenuIndex(_ index: Int) {
    print("index selected: \(index)")
    let selected = menuControllers[index]
    viewControllers.removeAll()
    pushViewController(selected, animated: false)
    popToRootViewController(animated: false)
    setMenuButtonToRootViewController(selected)
    
  }
}
