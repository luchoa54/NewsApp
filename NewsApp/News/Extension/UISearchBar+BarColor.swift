//
//  UISearchBar+BarColor.swift
//  NewsApp
//
//  Created by Luciano Uchoa on 14/05/24.
//

import UIKit

extension UISearchBar {
  /// This solves iOS 13 issue which is a light gray overay covers the textField.
  /// - Parameter color: A color for searchField
  func setSearchFieldBackgroundColor(_ color: UIColor) {
    searchTextField.backgroundColor = color
    setSearchFieldBackgroundImage(UIImage(), for: .normal)
    // Make up the default cornerRadius changed by `setSearchFieldBackgroundImage(_:for:)`
    searchTextField.layer.cornerRadius = 10
    searchTextField.clipsToBounds = true
  }
}
