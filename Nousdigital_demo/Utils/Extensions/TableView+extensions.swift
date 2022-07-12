//
//  TableView+extensions.swift
//  Nousdigital_demo
//
//  Created by Ievgenii on 12/07/2022.
//

import UIKit

extension UITableView {
    func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: Reusable & NibReusable {
        self.register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: Reusable>(cell: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T? where T: Reusable {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T?
    }
}

