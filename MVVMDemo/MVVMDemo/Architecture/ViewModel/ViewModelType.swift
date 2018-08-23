//
//  ViewModelType.swift
//  MVVMDemo
//
//  Created by Can Khac Nguyen on 8/22/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
