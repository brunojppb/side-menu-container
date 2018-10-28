//
//  ViewController.swift
//  sidemenutest
//
//  Created by Bruno Paulino on 28.10.18.
//  Copyright © 2018 bpaulino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let button = UIButton()
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
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    let c: [NSLayoutConstraint] = [
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ]
    NSLayoutConstraint.activate(c)
    button.setTitle(text, for: .normal)
    button.setTitleColor(.white, for: .normal)
    view.backgroundColor = color
    button.addTarget(self, action: #selector(onButtonClick), for: .touchUpInside)
  }
  
  @objc func onButtonClick() {
    let randomColor = UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)
    let vc = ViewController(text: "new controller", color: randomColor)
    navigationController?.pushViewController(vc, animated: true)
  }


}

