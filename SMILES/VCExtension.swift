//
//  VCExtension.swift
//  Resource Coach
//
//  Created by Apple on 29/12/20.
//  Copyright © 2020 Biipmi. All rights reserved.
//

import UIKit

extension UIViewController {
    func reloadViewFromNib() {
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view) // This line causes the view to be reloaded
    }
}
