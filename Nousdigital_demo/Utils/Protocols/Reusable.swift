//
//  Reusable.swift
//  Nousdigital_demo
//
//  Created by Ievgenii on 12/07/2022.
//

import UIKit

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}
extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
}

protocol NibReusable: Reusable {
    static var nib: UINib { get }
}
extension NibReusable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

extension UICollectionViewCell: Reusable { }

extension UITableViewCell: Reusable { }
