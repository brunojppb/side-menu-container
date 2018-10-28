//
//  OptionsViewController.swift
//  sidemenutest
//
//  Created by Bruno Paulino on 28.10.18.
//  Copyright © 2018 bpaulino. All rights reserved.
//

import UIKit

protocol OptionsViewControllerDelegate: class {
  func didSelectMenuIndex(_ index: Int)
}

class OptionsViewController: UITableViewController {
  
  private var isHidden = true
  private var panGesture: UIPanGestureRecognizer!
  private var maxPanCenter: CGFloat!
  private var minPanCenter: CGFloat!
  weak var delegate: OptionsViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(gesture:)))
    panGesture.delegate = self
    view.addGestureRecognizer(panGesture)
    let width = UIScreen.main.bounds.width / 1.3
    view.frame = CGRect(x: -width, y: 0, width: width, height: UIScreen.main.bounds.height)
    let center = view.bounds.width / 2
    maxPanCenter = center
    minPanCenter = -center
  }
  
  private var originalCenter: CGPoint = .zero
  @objc func didPan(gesture: UIPanGestureRecognizer) {
    let translation = gesture.translation(in: view)
    switch gesture.state {
    case .began: print("Gesture Began")
      originalCenter = view.center
      tableView.isScrollEnabled = false
    case .changed:
      // if the gesture is horizonal,
      // then lets move the menu
      if abs(translation.x) > abs(translation.y) {
        let x = min(maxPanCenter, max(minPanCenter, originalCenter.x + translation.x))
        view.center = CGPoint(x: x, y: originalCenter.y)
      }
    case .cancelled: print("Gesture cancelled")
    case .ended: print("Gesture ended")
      tableView.isScrollEnabled = true
      // user let menu go. Should scroll on or off the screen
      // depending on the current center position
      if view.center.x > 0 && view.center.x < maxPanCenter {
        // menu should open all the way
        toggleMenu(shouldHide: false)
      } else if view.center.x < 0 && view.center.x > minPanCenter {
        toggleMenu(shouldHide: true)
      }
    case .failed: print("Gesture failed")
    case .possible: print("Gesture possible")
    }
  }
  
  func toggleMenu() {
    toggleMenu(shouldHide: !isHidden)
  }
  
  private func toggleMenu(shouldHide: Bool) {
    let position = shouldHide ? -view.bounds.width : 0
    var newFrame = view.frame
    newFrame.origin.x = position
    UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
      self.view.frame = newFrame
    }) { _ in
      self.isHidden = shouldHide
    }
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
    cell.textLabel?.text = "Menu option \(indexPath.row)"
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Did select row \(indexPath.row)")
    toggleMenu()
    delegate?.didSelectMenuIndex(indexPath.row)
  }
  
}

// MARK: - UIGestureRecognizerDelegate
extension OptionsViewController: UIGestureRecognizerDelegate {
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    if let gesture = gestureRecognizer as? UIPanGestureRecognizer {
      let velocity = gesture.velocity(in: view)
      return abs(velocity.x) > abs(velocity.y)
    }
    return true
  }
  
}
