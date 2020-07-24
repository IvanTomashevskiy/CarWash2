//
//  UITableViewCell+Reuse.swift
//  OpenWeatherApp
//
//  Created by Иван on 22.07.2020.
//  Copyright © 2020 Ivan Tomashevskiy. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var identifier: String {
        
        return String(describing: self)
    }
    
    static var nibName: String {
        
        return String(describing: self)
    }
    
    class func register(with tableView: UITableView) {
        
        tableView.register(
            UINib(nibName: nibName, bundle: nil),
            forCellReuseIdentifier: identifier)
    }
}
