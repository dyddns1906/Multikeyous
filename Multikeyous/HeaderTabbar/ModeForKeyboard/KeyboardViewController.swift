//
//  KeyboardViewController.swift
//  Multikeyous
//
//  Created by Yongun Lim on 2021/02/18.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional

class KeyboardViewController: UIViewController {
    
    @IBOutlet weak var keyboard: UIView!
    @IBOutlet weak var keyboardStackView: UIStackView!
    @IBOutlet weak var keyboardShadowViewHeightConts: NSLayoutConstraint!
    
    static let defaultButtonSize = CGSize(width: 90, height: 110)
    static let defaultButtonRatio = CGSize(width: defaultButtonSize.width / defaultButtonSize.height, height: defaultButtonSize.height / defaultButtonSize.width)
    let buttonSpacing: CGFloat = 1
    let lineMaxButton: CGFloat = 10
    
    var buttonSize = CGSize.zero
    var disposeBag = DisposeBag()
    let viewModel = KeyboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        buttonSize.width = keyboard.frame.width - (buttonSpacing * lineMaxButton) / lineMaxButton
        buttonSize.height = buttonSize.width * KeyboardViewController.defaultButtonRatio.height
    }
    
    func setupBinding() {
        viewModel.keyboardHeightOb
            .asDriver(onErrorJustReturn: 300)
            .drive(onNext: { [weak self] (height) in
                guard let strongSelf = self else { return }
                strongSelf.keyboardShadowViewHeightConts.constant = height
            }).disposed(by: disposeBag)
    }
    
    @IBAction func keyboardWillShow(_ notification:NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            viewModel.keyboardHeightOb.accept(keyboardHeight)
        }
    }
    
    func setupUIForCommonTextKeyboard () {
        
    }
    
    func setupUIForSpecialTextKeyboard () {
    }
}
