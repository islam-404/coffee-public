//
//  AuthorizationPresenter.swift
//  coffee
//
//  Created islam on 03.11.2024.
//

import Foundation
//import UIComponents
//import Services
//import NetworkLayer

final class AuthorizationPresenter {
    
    // MARK: - Properties
    
    private weak var view: AuthorizationViewInput?
    private let interactor: AuthorizationInteractorInput
    private let router: AuthorizationRouterInput
    private let inputModel: AuthorizationInputModel
    private let dataConverter: AuthorizationDataConverterInput
    
    private var filds: [AuthTextFieldType: TextFieldInput] = [:]
    
    // MARK: - Init
    
    init(view: AuthorizationViewInput,
         interactor: AuthorizationInteractorInput,
         router: AuthorizationRouterInput,
         inputModel: AuthorizationInputModel,
         dataConverter: AuthorizationDataConverterInput) 
    {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.inputModel = inputModel
        self.dataConverter = dataConverter
    }
}

// MARK: - AuthorizationViewOutput
extension AuthorizationPresenter: AuthorizationViewOutput {
    
    func viewLoaded() {
        view?.setupInitialState()
        let data = dataConverter.convert(with: "", delegate: self)
        view?.updateData(data: data)
    }
}

// MARK: - AuthorizationInteractorOutput
extension AuthorizationPresenter: AuthorizationInteractorOutput {
    
    func didSuccessfullyAuthorization(data: LoginResponse) {
        inputModel.performAuthorizationAction(data: data)
    }
    
    func showEmailWarning(_ text: String) {
        filds[.email]?.showErrorState(errorText: text)
    }
    
    func showPasswordWarning(_ text: String) {
        filds[.password]?.showErrorState(errorText: text)
    }
}

// MARK: - TextFieldOutput
extension AuthorizationPresenter: TextFieldOutput {
    
//    func changeField(key: String, data: String) {}
    
    func setNewCell(key: String, cell: TextFieldInput) {
        if let key = AuthTextFieldType(rawValue: key) {
            filds[key] = cell
        }
    }
    
    func returnKeyboardTapped(key: String, text: String) {
        
        if let key = AuthTextFieldType(rawValue: key) {
            switch key {
            case .email:
                
                if let error = interactor.validateEmail(text) {
                    showEmailWarning(error)
                } else {
                    
                    let passwordText = filds[.password]?.getText() ?? ""
                    
                    if let error = interactor.validatePassword(text) {
                        showPasswordWarning(error)
                    } else {
                        interactor.login(login: text, passwod: passwordText)
                    }
                }
            case .password:
                
                if let error = interactor.validatePassword(text) {
                    showPasswordWarning(error)
                } else {
                    
                    let loginText = filds[.email]?.getText() ?? ""
                    
                    if let error = interactor.validateEmail(loginText) {
                        showEmailWarning(error)
                    } else {
                        interactor.login(login: loginText, passwod: text)
                    }
                }
            }
        }
    }
}

// MARK: - ButtonCVCellDelegate
extension AuthorizationPresenter: ButtonCVCellDelegate {
    
    func buttonViewTapped(key: String?) {
        
        switch ButtonKey(rawValue: key ?? "") {
            
        case .loginButton:
            let mail = filds[.email]?.getText() ?? ""
            let password = filds[.password]?.getText() ?? ""
            interactor.login(login: mail, passwod: password)
            
        case .registerButton:
            inputModel.delegate.openRegisterScreen()
            
        case .none:
            break
        }
    }
 }

// MARK: - ButtonCVCellDelegate
// extension AuthorizationPresenter: ButtonCVCellDelegate {  }
