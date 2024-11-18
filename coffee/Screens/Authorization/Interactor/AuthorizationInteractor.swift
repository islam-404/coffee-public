//
//  AuthorizationInteractor.swift
//  coffee
//
//  Created islam on 03.11.2024.
//

//import Services

final class AuthorizationInteractor {
    
    // MARK: - Properties
    
    weak var output: AuthorizationInteractorOutput?
    
    private let service: AuthServiceProtocol
    private let validator: AuthValidationServiceProtocol
    
    
    // MARK: - Init
    
    init(service: AuthServiceProtocol, validator: AuthValidationServiceProtocol) {
        self.service = service
        self.validator = validator
    }
}


// MARK: AuthorizationInteractorInput
extension AuthorizationInteractor: AuthorizationInteractorInput {
    
    func validateEmail(_ email: String) -> String? {
        do {
            try validator.validateAuthValidationEmail(email)
            return nil
        } catch let error {
            return error.localizedDescription
        }
    }
    
    func validatePassword(_ password: String) -> String? {
        do {
            try validator.validateAuthPassword(password)
            return nil
        } catch let error {
            return error.localizedDescription
        }
    }
    
    func login(login: String, passwod: String) {
        
        do {
            try validator.validateAuthValidationEmail(login)
            try validator.validateAuthPassword(passwod)
            
            service.login(login: login, password: passwod) { result in
                switch result {
                case .success(let responseData):
                    self.output?.didSuccessfullyAuthorization(data: responseData)
                case .failure:
                    self.output?.showPasswordWarning(AuthorizationValidationError.invalidLogin.localizedDescription)
                }
            }
            
        } catch let error {
            
            switch error {
                
            case .emptyEmail, .invalidFormatEmail:
                output?.showEmailWarning(error.localizedDescription)
                
            case .emptyPassword, .invalidLogin:
                output?.showPasswordWarning(error.localizedDescription)
                
            case .unknownError:
                print(error.localizedDescription)
            }
            print(error.localizedDescription)
        }
    }
}
