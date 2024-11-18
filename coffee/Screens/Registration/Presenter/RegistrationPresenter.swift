//
//  RegistrationPresenter.swift
//  coffee
//
//  Created islam on 17.11.2024.
//

import Foundation

final class RegistrationPresenter {
    
    // MARK: - Properties
    
    private weak var view: RegistrationViewInput?
    private let interactor: RegistrationInteractorInput
    private let router: RegistrationRouterInput
    private let inputModel: RegistrationInputModel
    private let dataConverter: RegistrationDataConverterInput
    
    private var filds: [RegistrationTextFieldType: TextFieldInput] = [:]
    
    // MARK: - Init
    
    init(view: RegistrationViewInput,
         interactor: RegistrationInteractorInput,
         router: RegistrationRouterInput,
         inputModel: RegistrationInputModel,
         dataConverter: RegistrationDataConverterInput) 
    {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.inputModel = inputModel
        self.dataConverter = dataConverter
    }
    
}

// MARK: - RegistrationViewOutput
extension RegistrationPresenter: RegistrationViewOutput {
    
    func viewLoaded() {
        view?.setupInitialState()
        let data = dataConverter.convert(with: "", delegate: self)
        view?.updateData(data: data)
    }
}

// MARK: - RegistrationInteractorOutput
extension RegistrationPresenter: RegistrationInteractorOutput {
    
    func didSuccessfullyAuthorization(data: LoginResponse) {
        inputModel.delegate.didSuccessAuthorization(data: data)
    }
    
    func showEmailWarning(_ text: String) {
        filds[.email]?.showErrorState(errorText: text)
    }
    
    func showPasswordWarning(_ text: String) {
        filds[.password]?.showErrorState(errorText: text)
    }
    
    func showConfirmPasswordWarning(_ text: String) {
        filds[.confirmPassword]?.showErrorState(errorText: text)
    }
}

// MARK: - TextFieldOutput
extension RegistrationPresenter: TextFieldOutput {
    
    func setNewCell(key: String, cell: TextFieldInput) {
        if let key = RegistrationTextFieldType(rawValue: key) {
            filds[key] = cell
        }
    }
    
    func returnKeyboardTapped(key: String, text: String) {
        
        if let key = RegistrationTextFieldType(rawValue: key) {
            
            switch key {
            case .email:
                
                if let error = interactor.validateEmail(text) {
                    showEmailWarning(error)
                } else {
                    let passwordText = filds[.password]?.getText() ?? ""
                    if let error = interactor.validatePassword(password: passwordText) {
                        showPasswordWarning(error)
                    } else {
                        filds[.confirmPassword]?.setFocus()
                    }
                }
            case .password:
                
                if let error = interactor.validatePassword(password: text) {
                    showPasswordWarning(error)
                } else {
                    
                    let loginText = filds[.email]?.getText() ?? ""
                    if let error = interactor.validateEmail(loginText) {
                        showEmailWarning(error)
                    } else {
                        filds[.confirmPassword]?.setFocus()
                    }
                }
            case .confirmPassword:
                
                let loginText = filds[.email]?.getText() ?? ""
                if let error = interactor.validateEmail(loginText) {
                    showEmailWarning(error)
                } else {
                    interactor.register(
                        login: loginText,
                        password: filds[.password]?.getText() ?? "",
                        confirmPassword: text
                    )
                }
            }
        }
    }
}

// MARK: - ButtonCVCellDelegate
extension RegistrationPresenter: ButtonCVCellDelegate {
    
    func buttonViewTapped(key: String?) {
        
        switch ButtonKey(rawValue: key ?? "") {
            
        case .loginButton:
            inputModel.delegate.openAuthorizationScreen()
        case .registerButton:
            
            let login = filds[.email]?.getText() ?? ""
            let password = filds[.password]?.getText() ?? ""
            let confirmPassword = filds[.confirmPassword]?.getText() ?? ""
            
            interactor.register(login: login,
                                password: password,
                                confirmPassword: confirmPassword)
            
        case .none:
            break
        }
    }
}
