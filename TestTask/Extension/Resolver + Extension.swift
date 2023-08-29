//
//  Resolver + Extension.swift
//  TestTask
//
//  Created by Daniil Chemaev on 29.08.2023.
//

import Swinject

extension Resolver {
    func resolve<T>() -> T {
        return resolve(T.self)!
    }

    func resolve<T>(name: String?) -> T {
        return resolve(T.self, name: name)!
    }

    func resolve<T, Arg1>(argument: Arg1) -> T {
        return resolve(T.self, argument: argument)!
    }
}
