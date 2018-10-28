//
//  ViewController.swift
//  sidemenutest
//
//  Created by Bruno Paulino on 28.10.18.
//  Copyright © 2018 bpaulino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let label = UILabel()
  let text: String
  let color: UIColor
  
  init(text: String, color: UIColor) {
    self.text = text
    self.color = color
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    label.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(label)
    let c: [NSLayoutConstraint] = [
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ]
    NSLayoutConstraint.activate(c)
    label.text = text
    label.textColor = .white
    view.backgroundColor = color
  }


}

