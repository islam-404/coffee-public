//
//  RegistrationDataConverter.swift
//  coffee
//
//  Created islam on 17.11.2024.
//

import UIKit

protocol RegistrationDataConverterInput {
    func convert(with model: String, delegate: AnyObject) -> CollectionViewModel
}

final class RegistrationDataConverter: RegistrationDataConverterInput {
    
    private typealias Section = CollectionViewModel.Section
    private typealias Row = CollectionViewModel.Section.Row
    
    func convert(with model: String, delegate: AnyObject) -> CollectionViewModel {
        
        var collectionVM = CollectionViewModel(sections: [])
        
        let topInset = ConstantLayoutSection.calculateTopInsetForCenteredSection(sectionHeight: 270)

        let layoutSection = ConstantLayoutSection.registrationAndAuthSection
        layoutSection.contentInsets.top = topInset
        
        var section = Section(rows: [], layout: layoutSection)
        
        guard let presenter = delegate as? RegistrationPresenter else { return collectionVM }
        
        let loginTextFieldModel = TextFieldCVCell.Model(key: RegistrationTextFieldType.email.rawValue, title: "e-mail", output: presenter, keyboardType: .email)
        section.rows.append(TextFieldCVCell.createCellConfigurator(with: loginTextFieldModel))
        
        let passwordTextFieldModel = TextFieldCVCell.Model(key: RegistrationTextFieldType.password.rawValue, title: "Пароль", output: presenter, keyboardType: .password)
        section.rows.append(TextFieldCVCell.createCellConfigurator(with: passwordTextFieldModel))
        
        let confirmPasswordTextFieldModel = TextFieldCVCell.Model(key: RegistrationTextFieldType.confirmPassword.rawValue, title: "Повторите пароль", output: presenter, keyboardType: .password)
        section.rows.append(TextFieldCVCell.createCellConfigurator(with: confirmPasswordTextFieldModel))
        
        section.rows.append(ButtonCVCell.createCellConfigurator(with:
                .init(key: ButtonKey.registerButton.rawValue, title: "Регистрация", output: presenter, style: .filled)))
        
        section.rows.append(ButtonCVCell.createCellConfigurator(with:
                .init(key: ButtonKey.loginButton.rawValue, title: "Вход", output: presenter, style: .textOnly)))
        collectionVM.sections.append(section)
        
        return collectionVM
    }
}
