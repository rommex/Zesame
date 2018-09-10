//
//  SingleContentViewController.swift
//  ZilliqaSDKiOSExample
//
//  Created by Alexander Cyon on 2018-09-08.
//  Copyright © 2018 Open Zesame. All rights reserved.
//

import UIKit

import RxSwift
import TinyConstraints

class SingleContentViewController<View, ViewModel>: UIViewController where View: UIView & SingleContentView, View.ViewModel == ViewModel {
    typealias Input = ViewModel.Input
    typealias Output = ViewModel.Output

    private let bag = DisposeBag()

    let contentView: View
    let viewModel: ViewModel

    init(view contentView: View = View(), viewModel: ViewModel) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.addSubview(contentView)
        contentView.edgesToSuperview()
        bind()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .bottom
        view.backgroundColor = .red
        contentView.backgroundColor = .white
    }

    // MARK: - Overrideable Methods
    func input() -> Input {
        fatalError("Abstract, override me please")
    }
}

private extension SingleContentViewController {
    func bind() {
        let output = viewModel.transform(input: input())
        contentView.populate(with: output).forEach { $0.disposed(by: bag) }
    }
}

class Scene<View, ViewModel>: SingleContentViewController<View, ViewModel> where View: UIView & ViewModelled, ViewModel == View.ViewModel, ViewModel.Input.FromController == NotUsed {

    override func input() -> Input {
        return Input(fromView: contentView.inputFromView)
    }
}

protocol ViewModelled: SingleContentView where ViewModel: ViewModelType {
    typealias InputFromView = ViewModel.Input.FromView
    var inputFromView: InputFromView { get }
}
