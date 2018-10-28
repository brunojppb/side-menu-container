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
  let backgroundView: UIView = UIView()
  
  let menuControllers: [UIViewController] = [
    ViewController(text: "menu 0", color: .red),
    ViewController(text: "menu 1", color: .blue),
    ViewController(text: "menu 2", color: .darkGray),
    ViewController(text: "menu 3", color: .green),
    ViewController(text: "menu 4", color: .purple)
  ]
  
  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
    setMenuButtonToRootViewController(rootViewController)
    optionsController.delegate = self
  }
  
  private func setMenuButtonToRootViewController(_ rootController: UIViewController) {
    let menuImage = UIImage(named: "menu")
    let menuButton = UIBarButtonItem(image: menuImage, style: .plain, target: self,
                                     action: #selector(onMenuSelect))
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
    view.addSubview(backgroundView)
    backgroundView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width,
                                  height: UIScreen.main.bounds.height)
    backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    backgroundView.alpha = 0
    addChild(optionsController)
    view.addSubview(optionsController.view)
    optionsController.view.translatesAutoresizingMaskIntoConstraints = false
    optionsController.didMove(toParent: self)
    optionsController.view.layer.zPosition = 999
    backgroundView.layer.zPosition = 998
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onMenuSelect))
    backgroundView.addGestureRecognizer(tapGesture)
  }
  
  @objc func onMenuSelect() {
    print("Menu selected")
    optionsController.toggleMenu()
  }
  
}

// MARK: - OptionsViewControllerDelegate
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
