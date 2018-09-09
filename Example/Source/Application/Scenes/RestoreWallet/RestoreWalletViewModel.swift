//
//  RestoreWalletViewModel.swift
//  ZilliqaSDKiOSExample
//
//  Created by Alexander Cyon on 2018-09-08.
//  Copyright © 2018 Open Zesame. All rights reserved.
//

import RxCocoa
import RxSwift
import ZilliqaSDK

struct RestoreWalletViewModel {
    private let bag = DisposeBag()

    typealias NavigationTo = Navigation<RestoreWalletNavigator>
    private let navigateTo: NavigationTo

    init(_ navigation: @escaping NavigationTo) {
        self.navigateTo = navigation
    }
}

extension RestoreWalletViewModel: ViewModelled {

    struct Input {
        let privateKey: Driver<String>
        let restoreTrigger: Driver<Void>
    }

    struct Output {}

    func transform(input: Input) -> Output {

        let wallet: Driver<Wallet> = input.privateKey
            .map { Wallet(privateKeyHex: $0) }
            .filterNil()

        input.restoreTrigger.withLatestFrom(wallet).do(onNext: {
            self.navigateTo(.restored($0))
        }).drive().disposed(by: bag)

        return Output()
    }
}
