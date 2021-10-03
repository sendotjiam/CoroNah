//
//  UITableView+Ext.swift
//  InfoCorona
//
//  Created by Sendo Tjiam on 12/09/21.
//

import UIKit

extension UITableView {
    func registerNib(with cellClass : AnyClass) {
        let className = String(describing: cellClass)
        NSLog(className)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    func dequeueCell<T>(with cellClass : T.Type) -> T?{
        return dequeueReusableCell(withIdentifier: String(describing: cellClass)) as? T
    }
    
}
