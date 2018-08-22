//
//  AppNavigator.swift
//  MVVMDemo
//
//  Created by Can Khac Nguyen on 8/22/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import Foundation
import Reusable

protocol AppNavigatorType {
    func toMain()
}

struct AppNavigator: AppNavigatorType {
    unowned let window: UIWindow
    
    func toMain() {
        let vc = RepoViewController.instantiate()
        let navigation = UINavigationController(rootViewController: vc)
        let navigator = RepoNavigator(navigation: navigation)
        let viewModel = RepoViewModel(navigator: navigator, useCase: RepoUsecase())
        vc.bindViewModel(to: viewModel)
        window.rootViewController = navigation
    }
}
