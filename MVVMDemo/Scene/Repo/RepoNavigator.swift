//
//  RepoNavigator.swift
//  MVVMDemo
//
//  Created by Can Khac Nguyen on 8/22/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import Foundation
import UIKit

protocol RepoNavigatorType {
    func toNothing()
}

struct RepoNavigator: RepoNavigatorType {
    unowned let navigation: UINavigationController
    
    func toNothing() {}
}
