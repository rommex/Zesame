//
//  CreateNewWalletNavigator.swift
//  ZilliqaSDKiOSExample
//
//  Created by Alexander Cyon on 2018-09-08.
//  Copyright © 2018 Open Zesame. All rights reserved.
//

import UIKit
import ZilliqaSDK

final class CreateNewWalletNavigator {

    private weak var navigationController: UINavigationController?
    private let didChooseWallet: (Wallet) -> Void

    init(navigationController: UINavigationController?, didChooseWallet: @escaping (Wallet) -> Void) {
        self.navigationController = navigationController
        self.didChooseWallet = didChooseWallet
    }

    deinit {
        print("💣 CreateNewWalletNavigator")
    }
}

extension CreateNewWalletNavigator: Navigator {

    enum Destination {
        case create
        case displayBackupInfo(Wallet)
        case created(Wallet)
    }

    func navigate(to destination: Destination) {
        if case let .created(newWallet) = destination {
            didChooseWallet(newWallet)
        } else {
            navigationController?.pushViewController(makeViewController(for: destination), animated: true)
        }
    }

    func start() {
        navigate(to: .create)
    }

}


private extension CreateNewWalletNavigator {
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .create:
            return CreateNewWalletController(viewModel: CreateNewWalletViewModel(navigator: self))
        default: fatalError("No support for `\(String(reflecting: destination))` yet")
        }
    }
}