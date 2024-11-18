//
//  TextFieldCVCell.swift
//  UIComponents
//
//  Created by islam on 05.11.2024.
//

import UIKit
import SnapKit
//import DataConverterUtilites

public protocol TextFieldInput: AnyObject {
    func getText() -> String?
    func showErrorState(errorText: String)
    func setFocus()
}

public protocol TextFieldOutput: AnyObject {
//    func changeField(key: String, data: String)
    func setNewCell(key: String, cell: TextFieldInput)
    func returnKeyboardTapped(key: String, text: String) // , _ isHiddeKeyboard: @escaping (Bool) -> Void
}

extension TextFieldOutput {
    func returnKeyboardTapped(key: String, _ isHiddeKeyboard: @escaping (Bool) -> Void) {}
}

public final class TextFieldCVCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    //MARK: - Views
    
    private let titleLabel = UILabel()
    private let textField = PaddedTextField()
    private let errorLabel = UILabel()
    
    weak var output: TextFieldOutput?
    private var key: String?
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("XZ cho")
    }
    
    //MARK: - Private func
    
    private func setupViews() {
        
        
        contentView.addSubview(titleLabel)
        titleLabel.text = "Title"
        titleLabel.textColor = .textCof
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        contentView.addSubview(textField)
        textField.placeholder = ""
        textField.backgroundColor = .clear
        textField.layer.cornerRadius = 24
        textField.tintColor = .textCof
        textField.textColor = .secondaryTextCof
        textField.textPadding.left = 18
        textField.textPadding.right = 18
        textField.delegate = self
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.textCof.cgColor
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(18)
            make.height.equalTo(48)
        }
        
        contentView.addSubview(errorLabel)
        errorLabel.text = ""
        errorLabel.isHidden = true
        errorLabel.textColor = .redCof
        errorLabel.font = .systemFont(ofSize: 12)
        errorLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.right.bottom.equalToSuperview()
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        textField.becomeFirstResponder()
    }
    
    @objc private func doneTap() {
        guard let key, let output else { return }
        output.returnKeyboardTapped(key: key, text: textField.text ?? "")
    }
}

extension TextFieldCVCell: TextFieldInput {
    
    public func getText() -> String? { textField.text }
    
    public func showErrorState(errorText: String) {
        errorLabel.text = errorText
        errorLabel.isHidden = false
        textField.layer.borderColor = UIColor.redCof.cgColor
        textField.becomeFirstResponder()
    }
    
    public func setFocus() {
        textField.becomeFirstResponder()
    }
}

// MARK: Configure
extension TextFieldCVCell: ConfigurableCVCell {

    public struct Model {
        let key: String
        let title: String
        let text: String?
        let output: TextFieldOutput
        let keyboardSetting: KeyboardSetting
        
        init(
            key: String,
            title: String,
            text: String? = nil,
            output: TextFieldOutput,
            keyboardType: KeyboardSetting = .defaultSetting
        ) {
            self.key = key
            self.title = title
            self.text = text
            self.output = output
            self.keyboardSetting = keyboardType
        }
    }
    
    public func configure(with model: Model) {
        key = model.key
        titleLabel.text = model.title
        textField.text = model.text
        output = model.output
        model.keyboardSetting.configuration.apply(to: textField)
        model.output.setNewCell(key: model.key, cell: self)
    }
}

// MARK: UITextFieldDelegate
extension TextFieldCVCell: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        doneTap()
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.textField.layer.borderColor = UIColor.textCof.cgColor
        errorLabel.isHidden = true
        return true
    }
}
