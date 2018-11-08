//
//  LoginViewModel.swift
//  MVVMC-SplitViewController
//
//  Created by Mathew Gacy on 1/1/18.
//  Copyright © 2018 Mathew Gacy. All rights reserved.
//

import RxCocoa
import RxSwift

final class LoginViewModel: ViewModelType {

    let isValid: Driver<Bool>
    let loggingIn: Driver<Bool>
    let loggedIn: Driver<Bool>
    let signupTaps: Driver<Void>
    let cancelTaps: Driver<Void>

    // MARK: - Lifecycle

    init(dependency: Dependency, bindings: Bindings) {
        let userInputs = Driver.combineLatest(
            bindings.username, bindings.password
        ) { (username, password) -> (String, String) in
            return (username, password)
        }

        isValid = userInputs
            .map { username, password in
                return username.count > 0 && password.count > 0
            }

        let loggingIn = ActivityIndicator()
        self.loggingIn = loggingIn.asDriver()

        loggedIn = Driver.merge(bindings.loginTaps, bindings.doneTaps)
            .withLatestFrom(userInputs)
            .flatMap { (arg) -> Driver<Bool> in
                let (username, password) = arg
                return dependency.userManager.login(username: username, password: password)
                    .trackActivity(loggingIn)
                    .asDriver(onErrorJustReturn: false)
            }
            //.share(replay: 1)

        signupTaps = bindings.signupTaps
        cancelTaps = bindings.cancelTaps
    }

    // MARK: - ViewModelType

    typealias Dependency = HasUserManager

    struct Bindings {
        let username: Driver<String>
        let password: Driver<String>
        let loginTaps: Driver<Void>
        let signupTaps: Driver<Void>
        let doneTaps: Driver<Void>
        let cancelTaps: Driver<Void>
    }

}
