//
//  RegistrationInteractor.swift
//  coffee
//
//  Created islam on 17.11.2024.
//

final class RegistrationInteractor {
    
    // MARK: - Properties
    weak var output: RegistrationInteractorOutput?
    
    private let service: AuthServiceProtocol
    private let validator: RegistrValidationServiceProtocol
    
    
    // MARK: - Init
    init(service: AuthServiceProtocol, validator: RegistrValidationServiceProtocol) {
        self.service = service
        self.validator = validator
    }
    
}


// MARK: - RegistrationInteractorInput
extension RegistrationInteractor: RegistrationInteractorInput {
    
    func validateEmail(_ email: String) -> String? {
        do {
            try validator.validateRegistrationEmail(email)
            return nil
        } catch let error {
            return error.localizedDescription
        }
    }
    
    func validatePassword(password: String) -> String? {
        do {
            try validator.validateRegistrationPassword(password)
            return nil
        } catch let error {
            return error.localizedDescription
        }
    }
    
    func register(login: String, password: String, confirmPassword: String) {
        
        do {
            try validator.validateRegistrationEmail(login)
            try validator.validateRegistrationPassword(password)
            try validator.validateRegistrationConfirmPassword(password, confirmPassword)
            
            service.register(login: login, password: password) { result in
                switch result {
                case .success(let responseData):
                    self.output?.didSuccessfullyAuthorization(data: responseData)
                case .failure:
                    self.output?.showPasswordWarning("Loging failed")
                }
            }
            
        } catch let error {
            
            switch error {
                
            case .emptyEmail, .invalidFormatEmail:
                output?.showEmailWarning(error.localizedDescription)
                
            case .emptyPassword, .tooShort, .lacksUppercase,
                    .lacksLowercase, .lacksDigit:
                output?.showPasswordWarning(error.localizedDescription)
                
            case .doesNotMatch:
                output?.showConfirmPasswordWarning(error.localizedDescription)
            }
        }
    }
}
